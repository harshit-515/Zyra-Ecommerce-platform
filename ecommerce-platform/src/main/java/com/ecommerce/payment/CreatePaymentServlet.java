package com.ecommerce.payment;

import com.ecommerce.util.PayPalConfig;
import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/paypal/create")
public class CreatePaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // 🔎 DEBUG: servlet hit or not
        System.out.println(">>> CreatePaymentServlet HIT");

        try {
            // 1️⃣ Get API Context
            APIContext apiContext = PayPalConfig.getApiContext();
            System.out.println(">>> APIContext created (sandbox)");

            // 2️⃣ Amount (MUST be USD)
            Amount amount = new Amount();
            amount.setCurrency("USD");
            amount.setTotal("10.00"); // TEST AMOUNT
            System.out.println(">>> Amount set");

            // 3️⃣ Transaction
            Transaction transaction = new Transaction();
            transaction.setAmount(amount);
            transaction.setDescription("E-Commerce Order Payment");

            List<Transaction> transactions = new ArrayList<>();
            transactions.add(transaction);

            // 4️⃣ Payer
            Payer payer = new Payer();
            payer.setPaymentMethod("paypal");

            // 5️⃣ Payment object
            Payment payment = new Payment();
            payment.setIntent("sale");
            payment.setPayer(payer);
            payment.setTransactions(transactions);

            // 6️⃣ Redirect URLs (ABSOLUTE URLs ONLY)
            RedirectUrls redirectUrls = new RedirectUrls();
            redirectUrls.setCancelUrl(
                "http://localhost:8080/ecommerce-platform/paypal/payment-error.jsp"
            );
            redirectUrls.setReturnUrl(
                "http://localhost:8080/ecommerce-platform/paypal/execute"
            );
            payment.setRedirectUrls(redirectUrls);

            System.out.println(">>> Redirect URLs set");

            // 7️⃣ Create payment on PayPal
            Payment createdPayment = payment.create(apiContext);
            System.out.println(">>> Payment created with ID: "
                    + createdPayment.getId());

            // 8️⃣ Print ALL PayPal links (CRITICAL DEBUG)
            for (Links link : createdPayment.getLinks()) {
                System.out.println("PAYPAL LINK => "
                        + link.getRel() + " : " + link.getHref());

                if ("approval_url".equalsIgnoreCase(link.getRel())) {
                    System.out.println(">>> Redirecting to PayPal Sandbox");
                    response.sendRedirect(link.getHref());
                    return;
                }
            }
            System.out.println("❌ approval_url NOT found");
            response.sendRedirect(
                request.getContextPath() + "/paypal/payment-error.jsp"
            );

        } catch (PayPalRESTException e) {
            System.out.println("🔥 PAYPAL EXCEPTION 🔥");
            e.printStackTrace();
            response.sendRedirect(
                request.getContextPath() + "/paypal/payment-error.jsp"
            );
        } catch (Exception e) {
            System.out.println("🔥 GENERAL EXCEPTION 🔥");
            e.printStackTrace();
            response.sendRedirect(
                request.getContextPath() + "/paypal/payment-error.jsp"
            );
        }
    }
}
