package com.ecommerce.util;

import java.util.HashMap;
import java.util.Map;

import com.paypal.base.rest.APIContext;

public class PayPalConfig {

    // Sandbox credentials (SAFE for college project)
    private static final String CLIENT_ID = "AZGUxlheXkhjce6mS4RMqnQbr1UFwHJj55lRnpEzVcbWWv1LZiagRZNT4lnGrqB3Pd2quoaddL4DUFMN";
    private static final String CLIENT_SECRET = "EHMENa69CFJP3bBzDumpV7Brs5jioU0xVTmuCUsL5kEmRH9XjleSg2tUiPZV4-xNuAQmeQ8q7LMpG3Xv";
    private static final String MODE = "sandbox";

    public static APIContext getApiContext() {
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

        Map<String, String> config = new HashMap<>();
        config.put("mode", MODE);

        apiContext.setConfigurationMap(config);
        return apiContext;
    }
}
