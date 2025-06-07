// Função para exibir os produtos do carrinho na página cart.html
function exibirCarrinho() {
    const carrinhoContainer = document.querySelector(".card-body");
    carrinhoContainer.innerHTML = ''; // Limpa o conteúdo atual

    // Obtém o carrinho do localStorage
    const carrinhoItens = JSON.parse(localStorage.getItem("carrinho")) || [];

    carrinhoItens.forEach(function (produto) {
        const preco = produto.temDesconto ? produto.precoComDesconto : produto.preco;

        carrinhoContainer.innerHTML += `
            <div class="row mb-3 justify-content-evenly">
                <div class="col-3">
                    <img src="${produto.imgUrl}" alt="Imagem do Produto" class="w-100 rounded">
                </div>
                <div class="col-5">
                    <h6 class="pb-0">${produto.nome}</h6>
                    ${getCategoriaIcon(produto.categoria)}
                </div>
                <div class="col-3">
                    <div class="row mb-2">
                        <div class="col-3 d-flex justify-content-center">
                            <button type="button" class="btn btn-sm btn-outline-danger mb-2" data-id="${produto.id}" onclick="removerProduto('${produto.id}')">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                        <div class="col-9">
                            <p><strong>R$ ${preco.toFixed(2)}</strong></p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-3 d-flex justify-content-center">
                            <button class="btn btn-dark me-2" onclick="alterarQuantidade('${produto.id}', 1)">
                                <i class="bi bi-plus"></i>
                            </button>
                        </div>
                        <div class="col-6 d-flex justify-content-center">
                            <input class="form-control text-center" type="number" min="1" value="${produto.quantidade}" readonly>
                        </div>
                        <div class="col-3 d-flex justify-content-center">
                            <button class="btn btn-dark ms-2" onclick="alterarQuantidade('${produto.id}', -1)">
                                <i class="bi bi-dash"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
        `;
    });

    atualizaOsValores(); // Atualiza os valores do resumo
}

// Função para obter o ícone da categoria (exemplo genérico)
function getCategoriaIcon(categoria) {
    switch (categoria) {
        case 'WINDOWS':
            return '<i class="bi bi-windows text-muted"></i>';
        case 'STEAM':
            return '<i class="bi bi-steam text-muted"></i>';
        case 'PLAYSTATION':
            return '<i class="bi bi-playstation text-muted"></i>';
        case 'XBOX':
            return '<i class="bi bi-xbox text-muted"></i>';
        case 'OUTROS':
            return '<i class="bi bi-nintendo-switch text-muted"></i>';
        default:
            return '';
    }
}

// Função para remover um produto do carrinho
function removerProduto(id) {
    let carrinhoItens = JSON.parse(localStorage.getItem("carrinho")) || [];
    carrinhoItens = carrinhoItens.filter(produto => produto.id !== id);
    localStorage.setItem("carrinho", JSON.stringify(carrinhoItens));
    exibirCarrinho(); // Atualiza o carrinho após remoção
}

// Função para alterar a quantidade de um produto
function alterarQuantidade(id, quantidade) {
    let carrinhoItens = JSON.parse(localStorage.getItem("carrinho")) || [];
    carrinhoItens = carrinhoItens.map(produto => {
        if (produto.id === id) {
            produto.quantidade = Math.max(1, produto.quantidade + quantidade); // Impede que a quantidade seja menor que 1
        }
        return produto;
    });
    localStorage.setItem("carrinho", JSON.stringify(carrinhoItens));
    exibirCarrinho(); // Atualiza o carrinho após alteração de quantidade
}

// Função para atualizar o valor do resumo
function atualizaOsValores() {
    let totalProdutos = 0;
    const carrinhoItens = JSON.parse(localStorage.getItem("carrinho")) || [];

    carrinhoItens.forEach(produto => {
        const precoNumerico = produto.temDesconto ? produto.precoComDesconto : produto.preco;
        totalProdutos += precoNumerico * produto.quantidade;
    });

    const valorPrazo = totalProdutos; // Total à prazo
    const valorVista = totalProdutos * 0.7; // Valor à vista com 30% de desconto
    const valorParcela = valorPrazo / 3; // 3 parcelas

    // Atualizar os elementos no HTML com o novo valor
    document.querySelector("ul.list-group li:nth-child(1) span").textContent = "R$ " + formatarNumero(totalProdutos);
    document.querySelector("ul.list-group li:nth-child(3) span").textContent = "R$ " + formatarNumero(valorPrazo);
    document.querySelector("ul.list-group li:nth-child(6) span").textContent = "R$ " + formatarNumero(valorVista); // Atualizando o valor à vista
    document.querySelector(".list-cust span").textContent = "(em até 3x de R$ " + formatarNumero(valorParcela) + " sem juros)";

    salvarValoresLocalStorage(valorPrazo, valorVista, valorParcela);
}

// Função para salvar valores no localStorage
function salvarValoresLocalStorage(prazo, vista, parcela) {
    localStorage.setItem('valorPrazo', prazo);
    localStorage.setItem('valorVista', vista);
    localStorage.setItem('valorParcela', parcela);
}

// Formata os valores do carrinho para o padrão brasileiro
function formatarNumero(numero) {
    return numero.toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

// Executa a função ao carregar a página
window.addEventListener('load', exibirCarrinho);

// Função para verificar se o usuário está logado com base na presença do ID
async function verificarLogin() {
    try {
        const response = await fetch("/api/auth/me", {
            method: 'GET',
            credentials: 'include',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            const data = await response.json();
            return data.id !== undefined; // Retorna true se o ID existir (usuário logado)
        } else {
            return false; // Se a requisição falhar, assume que o usuário não está logado
        }
    } catch (error) {
        console.error("Erro ao verificar o login:", error);
        return false;
    }
}

// Função para redirecionar o usuário para o checkout ou login
async function finalizarCompra() {
    const estaLogado = await verificarLogin();

    if (estaLogado) {
        // Se o cliente estiver logado, redireciona para o checkout
        window.location.href = "/checkout";
    } else {
        // Se o cliente NÃO estiver logado, redireciona para a tela de login
        window.location.href = "/login";
    }
}