function exibirItensCarrinho() {
    const carrinhoItens = JSON.parse(localStorage.getItem("carrinho")) || [];
    const cards = document.querySelectorAll(".card-body");
    const carrinhoContainer = cards[cards.length - 1];

    carrinhoContainer.innerHTML = '';

    carrinhoItens.forEach(produto => {
        const preco = produto.temDesconto ? produto.precoComDesconto : produto.preco;

        carrinhoContainer.innerHTML += `
            <div class="row mb-4 justify-content-evenly">
                <div class="row pb-3">
                    <div class="col-4">
                        <img src="${produto.imgUrl}" class="w-100" alt="Imagem do Produto">
                    </div>
                    <div class="col-8">
                        <h6 class="pb-0 text-truncate">${produto.nome}</h6>
                        ${getCategoriaIcon(produto.categoria)}
                    </div>
                </div>
                <div class="row">
                    <div class="d-flex mb-0 pb-0 justify-content-between">
                        <div class="row mb-0 pb-0">
                            <p class="text-start mb-0 pb-0">Valor: <strong>R$ ${preco.toFixed(2)}</strong></p>
                        </div>
                        <div class="row mb-0 pb-0">
                            <p class="text-start mb-0 pb-0">Qtd: <strong>${produto.quantidade}</strong></p>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
        `;
    });
}

function getCategoriaIcon(categoria) {
    switch (categoria) {
        case 'WINDOWS': return '<i class="bi bi-windows text-muted"></i>';
        case 'STEAM': return '<i class="bi bi-steam text-muted"></i>';
        case 'PLAYSTATION': return '<i class="bi bi-playstation text-muted"></i>';
        case 'XBOX': return '<i class="bi bi-xbox text-muted"></i>';
        case 'OUTROS': return '<i class="bi bi-nintendo-switch text-muted"></i>';
        default: return '';
    }
}

function exibirValorTotalCompra() {
    const valorPrazo = parseFloat(localStorage.getItem("valorPrazo")) || 0;
    const valorVista = parseFloat(localStorage.getItem("valorVista")) || 0;

    console.log("valorPrazo:", valorPrazo);
    console.log("valorVista:", valorVista);

    // Recupera o JSON de pedidos do localStorage e verifica se existe e está estruturado corretamente
    const pedidos = JSON.parse(localStorage.getItem("pedidos"));

    console.log("pedidos:", pedidos);

    // Verifica se a variável pedidos e sua propriedade formaPagamento existem
    if (pedidos && pedidos.formaPagamento) {
        const metodoPagamento = pedidos.formaPagamento; // Mover a definição para cá

        console.log("Método de pagamento:", metodoPagamento);

        // Seleciona o elemento do valor dos produtos
        const valorProdutosSpan = document.querySelector(".list-group-item span:nth-of-type(1)");

        // Define o valor a ser exibido com base no método de pagamento
        let valorExibir;
        if (metodoPagamento === "CARTAO_CREDITO") {
            valorExibir = valorPrazo;
        } else if (metodoPagamento === "BOLETO") {
            valorExibir = valorVista;
        } else {
            console.error("Método de pagamento inválido.");
            valorExibir = 0;
        }

        // Atualiza o conteúdo do span com o valor formatado
        valorProdutosSpan.textContent = "R$ " + formatarNumero(valorExibir);
    } else {
        console.error("Pedido ou método de pagamento não encontrado no localStorage.");
    }
}

// Função para formatar o número no padrão brasileiro
function formatarNumero(numero) {
    return numero.toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

// Chama a função ao carregar a página para exibir os itens do carrinho e o valor total
window.addEventListener('DOMContentLoaded', function() {
    exibirItensCarrinho();
    exibirValorTotalCompra();
});


// Função para validar o formulário do cartão de crédito
function validarFormularioCartaoCredito() {
    let camposValidos = true;
    const camposObrigatorios = [
        document.getElementById("cardNumber"),
        document.getElementById("expiryDate"),
        document.getElementById("cvv"),
        document.getElementById("cardName"),
        document.getElementById("cpf"),
        document.getElementById("billingAddress"),
        document.getElementById("billingCity"),
        document.getElementById("billingState"),
        document.getElementById("billingZip"),
    ];

    camposObrigatorios.forEach(campo => {
        if (!campo || campo.value.trim() === "") {
            campo.classList.add("is-invalid");
            camposValidos = false;
        } else {
            campo.classList.remove("is-invalid");
        }
    });

    return camposValidos;
}

// Função para validar o formulário de boleto
function validarFormularioBoleto() {
    let camposValidos = true;
    const camposObrigatorios = [
        document.querySelector(".payment-slip #cardName"),
        document.querySelector(".payment-slip #cpf"),
        document.querySelector(".payment-slip #dataNascimento"),
    ];

    camposObrigatorios.forEach(campo => {
        if (!campo || campo.value.trim() === "") {
            campo.classList.add("is-invalid");
            camposValidos = false;
        } else {
            campo.classList.remove("is-invalid");
        }
    });

    return camposValidos;
}

// Função para controlar o botão "Finalizar Compra"
document.querySelector(".btn2").addEventListener("click", function () {
    const pedidos = JSON.parse(localStorage.getItem("pedidos"));
    if (pedidos && pedidos.formaPagamento) {
        const metodoPagamento = pedidos.formaPagamento;
        let formularioValido;

        if (metodoPagamento === "CARTAO_CREDITO") {
            formularioValido = validarFormularioCartaoCredito();
        } else if (metodoPagamento === "BOLETO") {
            formularioValido = validarFormularioBoleto();
        }

        if (formularioValido) {
            // window.location.href = "/pages/payment.html"; // Finaliza a compra
            console.log("Compra finalizada com sucesso!");
        } else {
            console.log("Por favor, preencha todos os campos obrigatórios.");
        }
    } else {
        console.log("Erro ao recuperar o método de pagamento.");
    }
});
