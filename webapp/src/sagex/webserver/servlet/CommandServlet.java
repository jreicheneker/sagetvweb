package sagex.webserver.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sagex.webserver.command.AbstractCommand;
import sagex.webserver.command.CommandEnum;

/**
 * Creates a command object for the type of command specified in the "command" request parameter.
 * The CommandEnum class centralizes the list of commands and their metadata and uses a factory
 * pattern to determine which command should be run.
 */
public class CommandServlet extends HttpServlet
{
    private static final long serialVersionUID = -5782389621245504871L;

    @Override
    @SuppressWarnings("unchecked") // request.getParameter is no typed
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException
    {
        // handle form input as UTF-8 rather than ASCII
        // the jsps all specify that they should submit data as UTF-8
        req.setCharacterEncoding("UTF-8");
        
        AbstractCommand command = null;
        Map<String, String[]> params = req.getParameterMap();

        try
        {
            // Get the command parameter from the request
            String commandParam = req.getParameter("command");
            //String contextParam = req.getParameter("context");

            // Get the command enum, which can create the appropriate command
            CommandEnum commandEnum = CommandEnum.getEnumFromCommandName(commandParam);

            if (commandEnum == null)
            {
                // Invalid command
                throw new Exception("Unknown command " + commandParam);
            }

            // This is a hack.  Use it until a better architecture can be designed.
            // The convert button is on the same form as many other commands, all of which
            // need to submit to the Command action.  However, the convert button needs to call convert.jsp,
            // which is essentially a special confirmation page for conversions.
            if (commandEnum == CommandEnum.CONVERT)
            {
                if (!req.getHeader("Referer").endsWith("/Command"))
                {
                    RequestDispatcher disp = req.getRequestDispatcher("/m/convert.jsp");
                    disp.forward(req, resp);
                    return;
                }
            }

            // Determine whether the command requires confirmation from the user
            String confirmed = req.getParameter("confirmed");
            if ((commandEnum.isConfirmationRequired()) && (confirmed == null))
            {
                // The command requires confirmation but the user has not been prompted for confirmation
                // Determine the name of the confirmation page (will be different for desktop and mobile web clients)
                // Dispatch to the confirmation page
                String confirmationPage = getServletConfig().getInitParameter("Command Confirmation Page");
                RequestDispatcher dispatcher = req.getRequestDispatcher(confirmationPage);
                dispatcher.forward(req, resp);
                return;
            }
            else if ((!commandEnum.isConfirmationRequired()) || ("Yes".equalsIgnoreCase(confirmed)))
            {
                // Run the command.  Either it doesn't require confirmation, or the user has provided confirmation
                command = commandEnum.newCommand();

                command.setParameters(params);

                command.run();

                // forward/redirect, command may specify a redirect and that overrides the returnto parameter
                String redirect = command.getRedirect();
                if (redirect != null)
                {
                    resp.sendRedirect(redirect);
                    return;
                }
            }

            String[] returnto = params.get("returnto");
            if ((returnto != null) && (returnto.length > 0))
            {
                // The HTML form specified a page to return to after the command finishes or the user cancels the command
                resp.sendRedirect(returnto[0]);
            }
            else if ((commandEnum.isConfirmationRequired()) && ("No".equalsIgnoreCase(confirmed)))
            {
                // Confirmation is required and the user clicked "No".  No "returnto" page was specified so use the default.
                // choose correct canceled page for desktop or mobile version
                String canceledPage = getServletConfig().getInitParameter("Command Canceled Page");
                RequestDispatcher dispatcher = req.getRequestDispatcher(canceledPage);
                dispatcher.forward(req, resp);
                return;
            }
            else
            {
                // The command finished successfully.  No "returnto" page was specified so use the default.
                // choose correct applied page for desktop or mobile version
                String commandAppliedPage = getServletConfig().getInitParameter("Command Applied Page");
                RequestDispatcher dispatcher = req.getRequestDispatcher(commandAppliedPage);
                dispatcher.forward(req, resp);
                return;
            }
        }
        catch (Exception e)
        {
            // choose correct error page for desktop or mobile version
            e.printStackTrace();
            String errorPage = getServletConfig().getInitParameter("Command Error Page");
            RequestDispatcher dispatcher = req.getRequestDispatcher(errorPage);
            req.setAttribute("exception", e);
            dispatcher.forward(req, resp);
            return;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException
    {
        doGet(req, resp);
    }
}
