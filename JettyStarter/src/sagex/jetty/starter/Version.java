package sagex.jetty.starter;

public enum Version
{
    VERSION_1_0        ("1.0"),
    VERSION_1_0_01     ("1.0.01"),
    VERSION_1_0_02     ("1.0.02"),
    VERSION_1_1        ("1.1"),
    VERSION_1_2        ("1.2"),
    VERSION_1_3        ("1.3"),
    VERSION_1_4        ("1.4"),
    VERSION_1_5        ("1.5"),
    VERSION_1_6        ("1.6"),
    VERSION_1_7        ("1.7"),   // Sage v7 beta
    VERSION_1_7_1      ("1.7.1"), // Sage v7 beta
    VERSION_1_7_2      ("1.7.2"), // Sage v7 beta
    VERSION_1_7_3      ("1.7.3"), // Sage v7 beta
    VERSION_1_7_4      ("1.7.4"), // Sage v7 beta
    VERSION_1_7_5      ("1.7.5"), // Sage v7 beta
    VERSION_2_0_0      ("2.0.0"), // Sage v7 beta
    VERSION_2_0_1      ("2.0.1"), // Sage v7 beta
    VERSION_2_1_0      ("2.1.0"), // Sage v7
    VERSION_2_2_0      ("2.2.0"), // Sage v7
    VERSION_2_2_1      ("2.2.1"), // Sage v7
    VERSION_2_3_0      ("2.3.0"), // Sage v7
    
    CURRENT_VERSION    (VERSION_2_3_0.version);
    
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
