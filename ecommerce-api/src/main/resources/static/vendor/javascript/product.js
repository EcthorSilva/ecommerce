document.addEventListener("DOMContentLoaded", async function () {
    // Função para obter o ID do produto do local storage
    function getProdutoIdFromLocalStorage() {
        return localStorage.getItem('produtoId');
    }

    // Função para carregar os detalhes do produto
    async function carregarProduto(produtoId) {
        console.log('ID do produto que será carregado:', produtoId);
        try {
            const response = await fetch(`http://localhost:8080/api/produtos/${produtoId}`);
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

    // Função para exibir os detalhes do produto na página
    function exibirProduto(produto) {
        // Acessar o elemento que mostrará o preço
        const produtoPreco = document.getElementById('produto-preco');
        
        // Verifica se o produto tem desconto
        if (produto.temDesconto) {
            // Exibe o preço com desconto
            const precoComDesconto = produto.precoComDesconto.toFixed(2); // Preço com desconto
            const porcentagemDesconto = Math.round(((produto.preco - produto.precoComDesconto) / produto.preco) * 100); // Cálculo da porcentagem de desconto
            produtoPreco.innerHTML = `R$${precoComDesconto} <span class="badge text-bg-danger">-${porcentagemDesconto}%</span>`;
        } else {
            // Exibe o preço normal
            const precoNormal = produto.preco.toFixed(2); // Preço normal
            produtoPreco.innerHTML = `R$${precoNormal}`;
        }

        document.getElementById('produto-nome').textContent = produto.nome;
        document.getElementById('produto-categoria').textContent = produto.categoria;
        document.getElementById('produto-descricao').textContent = produto.descricaoDetalhada;

        // Atualiza a imagem de banner
        const imgBanner = document.querySelector('.img-fluid.border.rounded'); // Seletor para a imagem do banner
        if (imgBanner) {
            imgBanner.src = produto.imgUrl; // Define a imagem do banner
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
    }

    const produtoId = getProdutoIdFromLocalStorage();
    if (produtoId) {
        carregarProduto(produtoId);
    }
});

// validação
(function() {
    const scriptName = document.currentScript.src.split('/').pop();
    console.log(`${scriptName} carregado com sucesso`);
})();
