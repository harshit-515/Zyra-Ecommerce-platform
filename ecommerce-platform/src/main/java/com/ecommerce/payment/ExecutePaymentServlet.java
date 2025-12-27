package com.ecommerce.payment;

import com.ecommerce.util.PayPalConfig;
import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/paypal/execute")
public class ExecutePaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");

        try {
            APIContext apiContext = PayPalConfig.getApiContext();

            Payment payment = new Payment();
            payment.setId(paymentId);

            PaymentExecution execution = new PaymentExecution();
            execution.setPayerId(payerId);

            Payment executedPayment = payment.execute(apiContext, execution);

            if ("approved".equalsIgnoreCase(executedPayment.getState())) {
                request.setAttribute("payment", executedPayment);
                request.getRequestDispatcher("/paypal/payment-success.jsp")
                       .forward(request, response);
            } else {
                request.getRequestDispatcher("/paypal/payment-error.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(
                request.getContextPath() + "/paypal/payment-error.jsp"
            );
        }
    }
}
