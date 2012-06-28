package sagex.webserver;

public enum Version
{
    VERSION_PRERELEASE ("Pre-release"),
    VERSION_1_0        ("1.0"),
    VERSION_1_0_1      ("1.0.1"),
    VERSION_1_1        ("1.1"),
    VERSION_1_2        ("1.2"),
    VERSION_1_3        ("1.3.0"),
    VERSION_1_3_1      ("1.3.1"),
    VERSION_1_4_0      ("1.4.0"),
    VERSION_1_4_1      ("1.4.1"),
    VERSION_2_0_0      ("2.0.0"),
    VERSION_2_1_0      ("2.1.0"),
    
    CURRENT_VERSION    (VERSION_2_1_0.version);
    
    private String version = null;

    private Version(String version)
    {
        this.version = version;
    }

    @Override
    public String toString()
    {
        return version;
    }
}
