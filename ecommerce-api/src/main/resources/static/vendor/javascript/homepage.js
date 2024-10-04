// Função para calcular o desconto
function calcularDesconto(preco, precoComDesconto) {
    return Math.round(((preco - precoComDesconto) / preco) * 100);
}

// Função para obter o ícone da categoria
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

// Função para criar e adicionar os cards ao HTML
function adicionarCards(produtos, containerId) {
    const container = document.getElementById(containerId);

    // Limpa o container antes de adicionar novos cards
    container.innerHTML = '';

    produtos.forEach(produto => {
        const cardCol = document.createElement('div');
        cardCol.className = 'col-lg-3 col-md-6 mb-4 mb-lg-0';

        cardCol.innerHTML = `
            <div class="card">
                <img src="${produto.imgUrl}" alt="Imagem do Produto" class="card-img-top">
                <div class="card-body">
                    <h5 class="card-title text-truncate">${produto.nome}</h5>
                    ${getCategoriaIcon(produto.categoria)}&nbsp;
                    <div class="position-absolute bottom-0 end-0 p-2">
                        ${produto.temDesconto ? `
                            <h6 class="text-reset bg-dark bg-opacity-75 p-2 rounded" style="text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">
                                R$${produto.precoComDesconto.toFixed(2)} <span class="badge text-bg-danger">-${calcularDesconto(produto.preco, produto.precoComDesconto)}%</span>
                            </h6>` :
                `<h6 class="text-reset bg-dark bg-opacity-75 p-2 rounded" style="text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">R$${produto.preco.toFixed(2)}</h6>`
            }
                    </div>
                    <br>
                    <button type="button" class="btn btn-outline-secondary mt-3 ps-3 pe-3 btn-adicionar-carrinho"
                        data-id="${produto.id}"
                        data-nome="${produto.nome}"
                        data-categoria="${produto.categoria}"
                        data-preco="${produto.preco}"
                        data-precoComDesconto="${produto.precoComDesconto}"
                        data-temDesconto="${produto.temDesconto}"
                        data-imgUrl="${produto.imgUrl}">
                        <i class="bi bi-cart-plus"> adicionar</i>
                    </button>
                </div>
            </div>
        `;

        container.appendChild(cardCol);

        // Adicionar evento de clique para a imagem do produto
        cardCol.querySelector('.card-img-top').addEventListener('click', function() {
            redirecionarParaProduto(produto.id);
        });

        // Adicionar evento de clique para o nome do produto
        cardCol.querySelector('.card-title').addEventListener('click', function() {
            redirecionarParaProduto(produto.id);
        });
    });

    // Adicionar evento ao botão de adicionar ao carrinho
    document.querySelectorAll('.btn-adicionar-carrinho').forEach(button => {
        button.addEventListener('click', function() {
            let produto = {
                id: this.dataset.id,
                nome: this.dataset.nome,
                categoria: this.dataset.categoria,
                preco: parseFloat(this.dataset.preco),
                precoComDesconto: parseFloat(this.dataset.precocomdesconto), // Alterar para minúsculas
                temDesconto: this.dataset.temdesconto === 'true', // Alterar para minúsculas
                imgUrl: this.dataset.imgurl // Alterar para minúsculas
            };
            adicionarAoCarrinho(produto);
        });
    });
}

// Função para redirecionar para a página do produto
function redirecionarParaProduto(produtoId) {
    localStorage.setItem('produtoId', produtoId);
    window.location.href = '/product'; // Redireciona para product.html
}

// Função para adicionar produto ao carrinho
function adicionarAoCarrinho(produto) {
    let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];
    
    // Verifica se o produto já existe no carrinho
    let itemExistente = carrinho.find(item => item.id === produto.id);

    // Se o produto já existe, não faz nada
    if (itemExistente) {
        // alert("Você já adicionou esse produto ao carrinho!");
    } else {
        // Se não existe, adiciona o produto com quantidade 1
        produto.quantidade = 1; 
        carrinho.push(produto);
        localStorage.setItem('carrinho', JSON.stringify(carrinho));
        
        // Exibe o toast assim que o produto for adicionado ao carrinho
        showAddCartToast(produto.nome);
    }
}

let toastCount = 0; // Contador de toasts atualmente exibidos

// Função para exibir um toast indicando que o produto foi adicionado ao carrinho
function showAddCartToast(nomeDoJogo) {
    // Cria o elemento de toast
    const toast = document.createElement('div');
    toast.className = 'toast align-items-center text-bg-success border-0 position-fixed end-0 m-3';
    toast.style.zIndex = '1055';
    toast.style.bottom = `${10 + (toastCount * 80)}px`; // Calcula a posição do toast (80px de altura para cada toast)
    toast.role = 'alert';
    toast.ariaLive = 'assertive';
    toast.ariaAtomic = 'true';

    // Adiciona o conteúdo do toast
    toast.innerHTML = `
        <div class="d-flex">
            <div class="toast-body">
                ${nomeDoJogo} foi adicionado ao carrinho!
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    `;

    // Adiciona o toast ao body do documento
    document.body.appendChild(toast);
    toastCount++; // Incrementa o contador de toasts visíveis

    // Inicializa o Toast do Bootstrap (certifique-se de que o Bootstrap está incluído no seu projeto)
    const bootstrapToast = new bootstrap.Toast(toast);

    // Mostra o Toast
    bootstrapToast.show();

    // Remove o toast do DOM após ele desaparecer
    toast.addEventListener('hidden.bs.toast', () => {
        document.body.removeChild(toast);
        toastCount--; // Decrementa o contador de toasts visíveis

        // Atualiza a posição dos toasts restantes
        document.querySelectorAll('.toast').forEach((toast, index) => {
            toast.style.bottom = `${10 + (index * 80)}px`;
        });
    });
}

// Função para criar e adicionar os cards de mais vendidos ao HTML
function adicionarCardsMaisVendidos(produtos, containerId) {
    const container = document.getElementById(containerId);

    // Limpa o container antes de adicionar novos cards
    container.innerHTML = '';

    produtos.forEach((produto, index) => {
        const cardCol = document.createElement('div');
        cardCol.className = 'col-md-6';

        cardCol.innerHTML = `
            <div class="card mb-4">
                <div class="row g-2">
                    <div class="position-absolute ps-1">
                        <h4 class="text-reset p-1 rounded"><span class="badge text-bg-danger">${index + 1}</span></h4>
                    </div>
                    <div class="col-md-3">
                        <img src="${produto.imgUrl}" class="img-fluid rounded-start" style="width: 100%; height: 100%; object-fit: cover;" alt="Imagem do Produto">
                    </div>
                    <div class="col-md-8">
                        <div class="position-absolute bottom-0 end-0 p-2">
                            ${produto.temDesconto ? `
                                <h6 class="text-reset bg-dark bg-opacity-75 p-1 rounded" style="text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">
                                    R$${produto.precoComDesconto.toFixed(2)} <span class="badge text-bg-danger">-${calcularDesconto(produto.preco, produto.precoComDesconto)}%</span>
                                </h6>` : 
                                `<h6 class="text-reset bg-dark bg-opacity-75 p-1 rounded" style="text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">R$${produto.preco.toFixed(2)}</h6>`
                            }
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-truncate">${produto.nome}</h5>
                            <p class="card-text">${produto.descricao}</p>
                            <p class="card-text"><small class="text-body-secondary">Última atualização ${produto.ultimaAtualizacao}</small></p>
                        </div>
                    </div>
                </div>
            </div>
        `;

        container.appendChild(cardCol);
    });
}

// Função para fazer a requisição ao endpoint
async function carregarProdutos(distribuidor, containerId, distribuidorId) {
    try {
        const response = await fetch(`http://localhost:8080/api/produtos/distribuidor/${distribuidor}`);
        const data = await response.json();

        console.log(`${distribuidor} Fetching URL:`, response.url); // Log para depuração
        console.log(`${distribuidor} Produtos:`, data); // Log para depuração
        
        // Verificar se 'content' é um array
        if (Array.isArray(data.content)) {
            // Pegar apenas os 4 primeiros produtos
            const primeirosProdutos = data.content.slice(0, 4);
            adicionarCards(primeirosProdutos, containerId);
        } else {
            console.error('A resposta não contém um array de produtos.');
        }

        // Atualizar o nome do distribuidor no elemento <h2>
        const distribuidorElement = document.getElementById(distribuidorId);
        if (distribuidorElement) {
            distribuidorElement.textContent = distribuidor;
        } else {
            console.error(`Elemento do distribuidor "${distribuidor}" não encontrado.`);
        }
    } catch (error) {
        console.error('Erro ao carregar produtos:', error);
    }
}

// Função para carregar os jogos mais vendidos
async function carregarMaisVendidos(containerId) {
    try {
        const response = await fetch(`http://localhost:8080/api/produtos?page=0&size=10`);
        const data = await response.json();

        console.log('Mais vendidos Fetching URL:', response.url); // Log para depuração
        console.log('Produtos mais vendidos:', data); // Log para depuração
        
        // Verificar se 'content' é um array
        if (Array.isArray(data.content)) {
            adicionarCardsMaisVendidos(data.content, containerId);
        } else {
            console.error('A resposta não contém um array de produtos.');
        }
    } catch (error) {
        console.error('Erro ao carregar produtos mais vendidos:', error);
    }
}

// Chamar as funções para carregar os produtos quando a página carregar
document.addEventListener('DOMContentLoaded', function() {
    carregarProdutos('Warner Bros. Games', 'product-cards-1', 'distribuidor-1');
    carregarProdutos('Devolver', 'product-cards-2', 'distribuidor-2');
    carregarProdutos('Ubisoft', 'product-cards-3', 'distribuidor-3');
    carregarMaisVendidos('mais-vendidos-cards');
});

// validação
(function() {
    const scriptName = document.currentScript.src.split('/').pop();
    console.log(`${scriptName} carregado com sucesso`);
})();