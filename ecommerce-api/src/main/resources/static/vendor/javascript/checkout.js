document.addEventListener("DOMContentLoaded", function() {
    // Requisição para obter os e-mails do usuário
    fetch(`/api/auth/me`)
        .then(response => response.json())
        .then(data => {
            const emailSelect = document.getElementById("emailSelect");

            // Adiciona o email principal
            const primaryEmailOption = document.createElement("option");
            primaryEmailOption.value = data.email;
            primaryEmailOption.text = data.email;
            primaryEmailOption.selected = true;
            emailSelect.appendChild(primaryEmailOption);

            // Adiciona o email secundário, se existir
            if (data.emailSecundario) {
                const secondaryEmailOption = document.createElement("option");
                secondaryEmailOption.value = data.emailSecundario;
                secondaryEmailOption.text = data.emailSecundario;
                emailSelect.appendChild(secondaryEmailOption);
            }
        })
        .catch(error => console.error("Erro ao carregar dados do usuário:", error));

    // Carrega os valores do resumo do pedido a partir do localStorage
    exibirResumoPedido();

    // Adiciona o evento de clique para o botão "Continuar"
    document.querySelector(".btn2").addEventListener("click", salvarPedido);
});

// Função para exibir o resumo do pedido
function exibirResumoPedido() {
    // Obtém os valores do localStorage
    const valorVista = localStorage.getItem("valorVista") || "0.00";
    const valorProdutos = localStorage.getItem("valorPrazo") || "0.00";
    const valorPrazo = localStorage.getItem("valorPrazo") || "0.00";
    const valorParcela = localStorage.getItem("valorParcela") || "0.00";

    // Formata os valores no padrão brasileiro
    const valorVistaFormatado = formatarNumero(parseFloat(valorVista));
    const valorProdutosFormatado = formatarNumero(parseFloat(valorProdutos));
    const valorPrazoFormatado = formatarNumero(parseFloat(valorPrazo));
    const valorParcelaFormatado = formatarNumero(parseFloat(valorParcela));

    // Atualiza os elementos no HTML com os valores do resumo do pedido
    document.querySelector("ul.list-group li:nth-child(1) span").textContent = "R$ " + valorVistaFormatado;
    document.querySelector("ul.list-group li:nth-child(3) span").textContent = "R$ " + valorPrazoFormatado;
    document.querySelector(".list-cust span").textContent = "(em até 3x de R$ " + valorParcelaFormatado + " sem juros)";
}

function salvarPedido() {
    // Obtém os dados do carrinho do localStorage
    const carrinhoItens = JSON.parse(localStorage.getItem("carrinho")) || [];

    // Verifica se o carrinho está vazio
    if (carrinhoItens.length === 0) {
        console.log("Por favor, insira pelo menos um item no carrinho");
        exibirErroToast("Por favor, insira pelo menos um item no carrinho");
        return; // Impede que o pedido seja salvo no localStorage
    }

    const valorPrazo = parseFloat(localStorage.getItem("valorPrazo")) || 0.00;
    const valorVista = parseFloat(localStorage.getItem("valorVista")) || 0.00;

    // Obtém a forma de pagamento selecionada
    const formaPagamentoSelect = document.querySelector(".form-select");
    let formaPagamento = "CARTAO_CREDITO"; // Define um padrão

    switch (formaPagamentoSelect.value) {
        case "1":
            formaPagamento = "CARTAO_CREDITO";
            break;
        case "2":
            formaPagamento = "PIX";
            break;
        case "3":
            formaPagamento = "BOLETO";
            break;
    }

    // Organiza os itens do pedido conforme o formato necessário
    const itensPedido = carrinhoItens.map(item => {
        return {
            produtoId: item.id,
            nomeProduto: item.nome,
            valorUnitario: item.temDesconto ? item.precoComDesconto : item.preco,
            quantidade: item.quantidade
        };
    });

    // Define o valor total com base na escolha de pagamento à vista ou a prazo
    const valorTotal = formaPagamento === "CARTAO_CREDITO" ? valorPrazo : valorVista;

    // Estrutura o objeto de pedido para salvar no localStorage
    const pedido = {
        valorTotal: valorTotal,
        formaPagamento: formaPagamento,
        clienteId: 0, 
        itens: itensPedido
    };

    // Salva o pedido no localStorage
    localStorage.setItem("pedidos", JSON.stringify(pedido));
    console.log("Pedido salvo no localStorage:", pedido);

    // Redireciona para a página correspondente com base na forma de pagamento selecionada
    if (formaPagamento === "CARTAO_CREDITO") {
        window.location.href = "/payment/credit-card";
    } else if (formaPagamento === "BOLETO") {
        window.location.href = "/payment/payment-slip";
    } else {
        // Para outras formas de pagamento, adicione redirecionamentos conforme necessário
        console.log("Forma de pagamento não possui redirecionamento específico.");
    }
}

// Função para exibir o toast de erro
function exibirErroToast(mensagem) {
    const errorToast = document.getElementById("errorToast");
    const toastBody = errorToast.querySelector(".toast-body");

    // Define a mensagem de erro no corpo do toast
    toastBody.textContent = mensagem;

    // Cria uma instância do toast usando Bootstrap e exibe
    const toast = new bootstrap.Toast(errorToast);
    toast.show();
}

// Função para formatar números para o padrão brasileiro
function formatarNumero(numero) {
    return numero.toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}
