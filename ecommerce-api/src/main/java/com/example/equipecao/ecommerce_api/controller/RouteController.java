/*
 * Classe que controla as rotas da aplicação
 * 
 * Aqui são definidas as rotas para as páginas da aplicação.
 * Todas as paginas são retornadas com o nome da pasta onde estão localizadas
 * exemplo: "pages/login" retorna a pagina login.html que está na pasta pages
*/

package com.example.equipecao.ecommerce_api.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RouteController {

    // rota para pagina de login
    @GetMapping("/login")
    public String login() {
        return "pages/login";
    }
    // rota para a pagina de login backoffice
    @GetMapping("/backoffice-login")
    public String backofficeLogin() {
        return "pages/backoffice-login";
    }
    // rota para a pagina de backoffice
    @GetMapping("/backoffice")
    public String backoffice() {
        return "pages/backoffice";
    }
    // rota para a pagina de perfil 
    @GetMapping("/profile")
    public String profile() {
        return "pages/profile";
    }
    // rota para a pagina de catalogo
    @GetMapping("/catalog")
    public String catalog() {
        return "pages/catalog";
    }
    // rota para a pagina de carrinho
    @GetMapping("/cart")
    public String cart() {
        return "pages/cart";
    }
    // rota para a pagina de FAQ
    @GetMapping("/faq")
    public String faq() {
        return "pages/faq";
    }
    // rota para a pagina de cadastro
    @GetMapping("/signup")
    public String signup() {
        return "pages/signup";
    }
    // rota para a pagina de produto
    @GetMapping("/product")
    public String product() {
        return "pages/product";
    }
    // rota para a pagina de 401
    @GetMapping("/401")
    public String error401() {
        return "pages/401";
    }
    // rota para a pagina de checkout
    @GetMapping("/checkout")
    public String checkout() {
        return "pages/checkout";
    }
    // rota para a pagina de pagamento - cartão de crédito
    @GetMapping("/payment/credit-card")
    public String payment() {
        return "pages/payment/credit-card";
    }
    // rota para a pagina de pagamento - boleto
    @GetMapping("/payment/payment-slip")
    public String billet() {
        return "pages/payment/payment-slip";
    }
}