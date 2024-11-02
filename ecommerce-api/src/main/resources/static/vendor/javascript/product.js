document.addEventListener("DOMContentLoaded", async function () {
    // Função para obter o ID do produto do local storage
    function getProdutoIdFromLocalStorage() {
        return localStorage.getItem('produtoId');
    }

    // Função para carregar os detalhes do produto
    async function carregarProduto(produtoId) {
        console.log('ID do produto que será carregado:', produtoId);
        try {
            const response = await fetch(`/api/produtos/${produtoId}`);
            if (!response.ok) {
                throw new Error('Erro ao carregar produto');
            }
            const contentType = response.headers.get("content-type");
            if (!contentType || !contentType.includes("application/json")) {
                throw new TypeError("Resposta não é JSON");
            }
            const produto = await response.json();
            console.log('Produto recuperado:', produto); // Exibir produto recuperado
            exibirProduto(produto);
        } catch (error) {
            console.error("Erro ao carregar produto:", error);
        }
    }

    // Função para obter o ícone da avaliação
    function getRatingIcon(rating) {
        switch (rating) {
            case 'full':
                return '<i class="bi bi-star-fill fs-5 text-muted"></i>';
            case 'half':
                return '<i class="bi bi-star-half fs-5 text-muted"></i>';
            default:
                return '<i class="bi bi-star fs-5 text-muted"></i>';
        }
    }

    // Função para gerar as estrelas com base na avaliação
    function generateStars(rating) {
        let starsHtml = '';
        for (let i = 1; i <= 5; i++) {
            if (rating >= i) {
                starsHtml += `<li class="list-group-item pe-2">${getRatingIcon('full')}</li>`;
            } else if (rating >= i - 0.5) {
                starsHtml += `<li class="list-group-item pe-2">${getRatingIcon('half')}</li>`;
            } else {
                starsHtml += `<li class="list-group-item pe-2">${getRatingIcon('empty')}</li>`;
            }
        }
        return starsHtml;
    }


    // Função para exibir os detalhes do produto na página
    function exibirProduto(produto) {
        const produtoPreco = document.getElementById('produto-preco');

        // Verifica se o produto tem desconto
        if (produto.temDesconto) {
            const precoComDesconto = produto.precoComDesconto.toFixed(2);
            const porcentagemDesconto = Math.round(((produto.preco - produto.precoComDesconto) / produto.preco) * 100);
            produtoPreco.innerHTML = `<span class="badge text-bg-danger">-${porcentagemDesconto}%</span> R$${precoComDesconto}`;
            produtoPreco.dataset.preco = produto.preco;
            produtoPreco.dataset.precoComDesconto = produto.precoComDesconto;
            produtoPreco.dataset.temDesconto = 'true';
        } else {
            const precoNormal = produto.preco.toFixed(2);
            produtoPreco.innerHTML = `R$${precoNormal}`;
            produtoPreco.dataset.preco = produto.preco;
            produtoPreco.dataset.temDesconto = 'false';
        }

        document.getElementById('produto-nome').textContent = produto.nome;
        document.getElementById('titulo-produto').textContent = produto.nome + ' | Ecommerce';
        document.getElementById('produto-categoria').textContent = produto.categoria;
        document.getElementById('produto-descricao').textContent = produto.descricaoDetalhada;

        document.getElementById('desenvolvedorNome').textContent = produto.distribuidor;
        document.getElementById('distribuidorNome').textContent = produto.distribuidor;

        // Atualiza a imagem de banner
        const imgBanner = document.querySelector('.img-fluid.border.rounded');
        if (imgBanner) {
            imgBanner.src = produto.imgUrl;
        } else {
            console.error("Elemento da imagem do banner não encontrado");
        }

        // Atualizar o ícone da categoria
        const categoriaIcon = document.getElementById('produto-categoria-icon');
        categoriaIcon.className = `bi bi-${produto.categoria.toLowerCase()}`;

        // Atualizar o carousel com as imagens do produto
        const carouselIndicators = document.getElementById('carousel-indicators');
        const carouselInner = document.getElementById('carousel-inner');

        // Limpar imagens anteriores
        carouselInner.innerHTML = '';
        carouselIndicators.innerHTML = '';

        produto.imagens.forEach((imagem, index) => {
            const indicator = document.createElement('button');
            indicator.type = 'button';
            indicator.dataset.bsTarget = '#carouselExample';
            indicator.dataset.bsSlideTo = index;
            if (index === 0) {
                indicator.className = 'active';
                indicator.ariaCurrent = 'true';
            }
            indicator.ariaLabel = `Slide ${index + 1}`;
            carouselIndicators.appendChild(indicator);

            const carouselItem = document.createElement('div');
            carouselItem.className = `carousel-item ${index === 0 ? 'active' : ''}`;
            const img = document.createElement('img');
            img.src = imagem.nomeImagem;
            img.className = 'd-block w-100';
            carouselItem.appendChild(img);
            carouselInner.appendChild(carouselItem);
        });

        // Atualizar as estrelas de avaliação
        const ratingStars = document.getElementById('rating-stars');
        if (ratingStars) {
            ratingStars.innerHTML = generateStars(produto.avaliacao);
        } else {
            console.error("Elemento de avaliação não encontrado");
        }
    }

    const produtoId = getProdutoIdFromLocalStorage();
    if (produtoId) {
        carregarProduto(produtoId);
    }

    // Função para adicionar ao carrinho o produto atual
    function adicionarProdutoAtualAoCarrinho() {
        const produto = {
            id: localStorage.getItem('produtoId'),
            nome: document.getElementById('produto-nome').textContent,
            categoria: document.getElementById('produto-categoria').textContent,
            preco: parseFloat(document.getElementById('produto-preco').dataset.preco),
            precoComDesconto: parseFloat(document.getElementById('produto-preco').dataset.precoComDesconto || document.getElementById('produto-preco').dataset.preco),
            temDesconto: document.getElementById('produto-preco').dataset.temDesconto === 'true',
            imgUrl: document.querySelector('.img-fluid.border.rounded').src,
        };

        // Adiciona o produto ao carrinho
        adicionarAoCarrinho(produto); // Certifique-se de que essa função está definida em um escopo acessível
    }

    // Adicionar evento ao botão "Adicionar ao Carrinho"
    const btnAdicionarCarrinho = document.getElementById('adicionar-carrinho');
    if (btnAdicionarCarrinho) {
        btnAdicionarCarrinho.addEventListener('click', adicionarProdutoAtualAoCarrinho);
    }
});

// Função para adicionar produto ao carrinho (defina aqui ou importe de outro módulo)
function adicionarAoCarrinho(produto) {
    let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];
    let itemExistente = carrinho.find(item => item.id === produto.id);

    if (itemExistente) {
        itemExistente.quantidade += 1;
    } else {
        produto.quantidade = 1;
        carrinho.push(produto);
    }

    localStorage.setItem('carrinho', JSON.stringify(carrinho));

    // Exibe o toast assim que o produto for adicionado ao carrinho
    showAddCartToast(produto.nome);
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
            toast.style.bottom = `${10 + (index * 60)}px`;
        });
    });
}

// validação
(function () {
    const scriptName = document.currentScript.src.split('/').pop();
    console.log(`${scriptName} carregado com sucesso`);
})();
