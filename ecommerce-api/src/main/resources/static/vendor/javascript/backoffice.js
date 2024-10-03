document.addEventListener('DOMContentLoaded', function() {
    // variaveis
    let paginaAtual = 0;
    let totalPaginas = 0;

    let estadoOriginalSwitch = null;
    let switchElementAtual = null;

    /* Usuarios */ 
    async function carregarUsuarios() {
        try {
            const response = await fetch('http://localhost:8080/api/usuarios');
            if (!response.ok) {
                throw new Error('Erro ao buscar usuários');
            }
            const usuarios = await response.json();
            preencherTabelaUsuarios(usuarios);
        } catch (error) {
            console.error('Erro:', error);
        }
    }
    // Preenche a tabela de usuários
    function preencherTabelaUsuarios(usuarios) {
        const tabelaUsuarios = document.getElementById('tabelaUsuarios').getElementsByTagName('tbody')[0];
        tabelaUsuarios.innerHTML = ''; // Limpa a tabela antes de preencher

        usuarios.forEach(usuario => {
            const row = tabelaUsuarios.insertRow();
            row.insertCell(0).innerText = usuario.id;
            row.insertCell(1).innerText = usuario.nome;
            row.insertCell(2).innerText = usuario.email;
            row.insertCell(3).innerText = usuario.grupo;
            row.insertCell(4).innerHTML = `
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox" id="statusSwitch${usuario.id}" ${usuario.ativo ? 'checked' : ''}>
                    <label class="form-check-label" for="statusSwitch${usuario.id}">${usuario.ativo ? 'Ativo' : 'Inativo'}</label>
                </div>
            `;
            row.insertCell(5).innerHTML = `
                <button class="btn btn-outline-light">Editar</button>
            `;

            // Adiciona evento de clique ao switch
            const switchElement = row.querySelector(`#statusSwitch${usuario.id}`);
            switchElement.addEventListener('change', function () {
                usuarioIdParaAtualizar = usuario.id;
                novoStatusUsuario = switchElement.checked;
                estadoOriginalSwitch = !novoStatusUsuario; // Armazena o estado original
                switchElementAtual = switchElement; // Armazena o elemento atual do switch
                exibirModalConfirmacao(usuario.ativo);
            });
        });
    }
    // Cadastrar novo usuário
    async function cadastrarUsuario() {
        const nome = document.getElementById("nomeUsuario").value;
        const cpf = document.getElementById("cpfUsuario").value;
        const email = document.getElementById("emailUsuario").value;
        const grupo = document.getElementById("grupoUsuario").value;
        const senha = document.getElementById("senhaUsuario").value;
        const confirmarSenha = document.getElementById("confirmarSenhaUsuario").value;
    
        // Validação
        if (!nome || !cpf || !email || !grupo || !senha || !confirmarSenha) {
            exibirErro("Todos os campos são obrigatórios.");
            return;
        }
    
        if (!validarEmail(email)) {
            exibirErro("Email inválido.");
            return;
        }
    
        if (!validarCPF(cpf)) {
            exibirErro("CPF inválido.");
            return;
        }
    
        if (senha !== confirmarSenha) {
            exibirErro("As senhas não coincidem.");
            return;
        }
    
        const senhaCriptografada = btoa(senha); // Simulação de criptografia, substitua por uma real
    
        const dados = {
            nome: nome,
            cpf: cpf,
            email: email,
            senha: senhaCriptografada,
            grupo: grupo,
            ativo: true
        };
    
        // Cadastrar novo usuário
        try {
            const response = await fetch('http://localhost:8080/api/usuarios', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(dados)
            });
    
            if (!response.ok) {
                throw new Error('Erro ao cadastrar usuário');
            }
    
            // Definir no localStorage que o toast deve ser exibido após recarregar a página
            localStorage.setItem('showUserToast', 'true');
    
            // Recarregar a página para atualizar as informações
            location.reload();
    
        } catch (error) {
            console.error('Erro:', error);
            exibirErro('Erro ao cadastrar usuário');
        }
    }
    // Adiciona o evento ao botão de salvar
    document.getElementById("salvarUsuario").addEventListener("click", cadastrarUsuario);
    
    // Alterar o status do usuário
    async function atualizarStatusUsuario(id, status) {
        if (id === usuarioLogadoId) {
            exibirErroToast('Você não pode desativar o seu próprio usuário');
            switchElementAtual.checked = estadoOriginalSwitch; // Restaura o estado original do switch
        }else{
            try {
                const response = await fetch(`http://localhost:8080/api/usuarios/${id}/status?ativo=${status}`, {
                    method: 'PATCH'
                });
                if (!response.ok) {
                    throw new Error('Erro ao atualizar status do usuário');
                }
                carregarUsuarios(); // Recarrega a tabela de usuários
            } catch (error) {
                console.error('Erro:', error);
            }
        }
    }
    // Modal para confirmar a alteração do status do usuario
    function exibirModalConfirmacao(ativo) {
        const mensagem = ativo ? 'Deseja desativar este usuário?' : 'Deseja ativar este usuário?';
        document.getElementById('confirmacaoMensagem').innerText = mensagem;
        const confirmacaoModal = new bootstrap.Modal(document.getElementById('confirmacaoModal'));
        confirmacaoModal.show();
        // caso aceite
        document.getElementById('confirmarAcao').addEventListener('click', async function () {
            if (usuarioIdParaAtualizar !== null && novoStatusUsuario !== null) {
                await atualizarStatusUsuario(usuarioIdParaAtualizar, novoStatusUsuario);
                usuarioIdParaAtualizar = null;
                novoStatusUsuario = null;
                const confirmacaoModal = bootstrap.Modal.getInstance(document.getElementById('confirmacaoModal'));
                confirmacaoModal.hide();
            }
        });
        // caso recuse
        document.querySelector('#confirmacaoModal .btn-secondary').addEventListener('click', function () {
            if (switchElementAtual !== null && estadoOriginalSwitch !== null) {
                switchElementAtual.checked = estadoOriginalSwitch; // Restaura o estado original do switch
                switchElementAtual = null;
                estadoOriginalSwitch = null;
            }
        });
    }

    /* Produtos */ 
    // Função para carregar produtos
    async function carregarProdutos(pagina = 0) {
        try {
            const response = await fetch(`/api/produtos?page=${pagina}&size=10`);
            const data = await response.json();
            console.log('Produtos:', data.content); // Log para exibir o array de produtos
            totalPaginas = data.totalPages;
            preencherTabelaProdutos(data.content);
            atualizarPaginacao();
        } catch (error) {
            console.error('Erro ao carregar produtos:', error);
        }
    }
    // Tornar a função carregarProdutosPesquisa globalmente acessível
    window.carregarProdutosPesquisa = async function carregarProdutosPesquisa(nomeProduto) {
        try {
            const response = await fetch(`http://localhost:8080/api/produtos/search?nome=${nomeProduto}`);
            if (!response.ok) {
                throw new Error('Erro ao buscar produtos');
            }
            const produtos = await response.json();
            console.log('Produtos da pesquisa:', produtos); // Log para exibir o array de produtos da pesquisa

            if (produtos.length === 0) {
                document.getElementById('alertaPesquisa').classList.remove('d-none');
                document.getElementById('tabelaProdutosPesquisa').classList.add('d-none');
                document.getElementById('tabelaProdutos').classList.add('d-none');
            } else {
                preencherTabelaProdutosPesquisa(produtos);
                document.getElementById('alertaPesquisa').classList.add('d-none');
                document.getElementById('tabelaProdutosPesquisa').classList.remove('d-none');
                document.getElementById('tabelaProdutos').classList.add('d-none');
            }
        } catch (error) {
            console.error('Erro ao carregar produtos:', error);
        }
    }
    document.getElementById('barraDePesquisa').addEventListener('input', function () {
        const nomeProduto = this.value.trim();

        if (nomeProduto === '') {
            // Se o campo estiver vazio, exibir todos os produtos
            document.getElementById('tabelaProdutos').classList.remove('d-none');
            document.getElementById('tabelaProdutosPesquisa').classList.add('d-none');
            carregarProdutos(); // Carregar todos os produtos
        } else {
            // Se houver texto, buscar produtos com o nome especificado
            carregarProdutosPesquisa(nomeProduto);
        }
    });
    // Função para carregar produtos com base na pesquisa
    async function carregarProdutosPesquisa(nomeProduto) {
        try {
            const response = await fetch(`http://localhost:8080/api/produtos/search?nome=${nomeProduto}`);
            if (!response.ok) {
                throw new Error('Erro ao buscar produtos');
            }
            const produtos = await response.json();

            if (produtos.length === 0) {
                document.getElementById('alertaPesquisa').classList.remove('d-none');
                document.getElementById('tabelaProdutosPesquisa').classList.add('d-none');
                document.getElementById('tabelaProdutos').classList.add('d-none');
            } else {
                preencherTabelaProdutosPesquisa(produtos);
                document.getElementById('alertaPesquisa').classList.add('d-none');
                document.getElementById('tabelaProdutosPesquisa').classList.remove('d-none');
                document.getElementById('tabelaProdutos').classList.add('d-none');
            }
        } catch (error) {
            console.error('Erro ao carregar produtos:', error);
        }
    }
    // Preencher a tabela de pesquisa
    function preencherTabelaProdutosPesquisa(produtos) {
        const tabelaProdutosPesquisa = document.getElementById('tabelaProdutosPesquisa').getElementsByTagName('tbody')[0];
        tabelaProdutosPesquisa.innerHTML = '';

        produtos.forEach(produto => {
            const row = tabelaProdutosPesquisa.insertRow();
            row.insertCell(0).innerText = produto.id;
            row.insertCell(1).innerText = produto.nome;
            row.insertCell(2).innerText = produto.quantidadeEmEstoque;
            row.insertCell(3).innerText = produto.preco;
            row.insertCell(4).innerHTML = `
            <div class="form-check form-switch">
                <input class="form-check-input" type="checkbox" id="statusSwitch${produto.id}" ${produto.ativo ? 'checked' : ''}>
                <label class="form-check-label" for="statusSwitch${produto.id}">${produto.ativo ? 'Ativo' : 'Inativo'}</label>
            </div>
            `;
                row.insertCell(5).innerHTML = `
                <button class="btn btn-outline-light">Editar</button>
            `;
        });
    }
    // Preenche a tabela de produtos
    function preencherTabelaProdutos(produtos) {
        const tabelaProdutos = document.getElementById('tabelaProdutos').getElementsByTagName('tbody')[0];
        tabelaProdutos.innerHTML = '';
        
        produtos.forEach(produto => {
            const row = tabelaProdutos.insertRow();
            row.insertCell(0).innerText = produto.id;
            row.insertCell(1).innerText = produto.nome;
            row.insertCell(2).innerText = produto.quantidadeEmEstoque;
            row.insertCell(3).innerText = produto.preco;
            row.insertCell(4).innerHTML = `
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox" id="statusSwitch${produto.id}" ${produto.ativo ? 'checked' : ''}>
                    <label class="form-check-label" for="statusSwitch${produto.id}">${produto.ativo ? 'Ativo' : 'Inativo'}</label>
                </div>
            `;
            row.insertCell(5).innerHTML = `
                <button class="btn btn-outline-light">Editar</button>
            `;

            // Adiciona evento de clique ao switch
            const switchElement = row.querySelector(`#statusSwitch${produto.id}`);
            switchElement.addEventListener('change', function () {
                produtoIdParaAtualizar = produto.id;
                novoStatusProduto = switchElement.checked;
                estadoOriginalSwitch = !novoStatusProduto; // Armazena o estado original
                switchElementAtual = switchElement; // Armazena o elemento atual do switch
                exibirModalConfirmacaoProduto(produto.ativo);
            });
        });
    }
    // alterar status do produto
    async function atualizarStatusProduto(id, status) {
        try {
            const response = await fetch(`http://localhost:8080/api/produtos/${id}/status?ativo=${status}`, {
                method: 'PATCH'
            });
            if (!response.ok) {
                throw new Error('Erro ao atualizar status do produto');
            }
            carregarProdutos(); // Recarrega a tabela de produtos
        } catch (error) {
            console.error('Erro:', error);
        }
    }
    // Modal para confirmar a alteração do status do produto
    function exibirModalConfirmacaoProduto(ativo) {
        const mensagem = ativo ? 'Deseja desativar este produto?' : 'Deseja ativar este produto?';
        document.getElementById('confirmacaoMensagemProduto').innerText = mensagem;
        const confirmacaoModal = new bootstrap.Modal(document.getElementById('confirmacaoModalProduto'));
        confirmacaoModal.show();
        // caso aceite
        document.getElementById('confirmarAcaoProduto').addEventListener('click', async function () {
            if (produtoIdParaAtualizar !== null && novoStatusProduto !== null) {
                await atualizarStatusProduto(produtoIdParaAtualizar, novoStatusProduto);
                produtoIdParaAtualizar = null;
                novoStatusProduto = null;
                const confirmacaoModal = bootstrap.Modal.getInstance(document.getElementById('confirmacaoModalProduto'));
                confirmacaoModal.hide();
            }
        });
        // caso recuse
        document.querySelector('#confirmacaoModalProduto .btn-secondary').addEventListener('click', function () {
            if (switchElementAtual !== null && estadoOriginalSwitch !== null) {
                switchElementAtual.checked = estadoOriginalSwitch; // Restaura o estado original do switch
                switchElementAtual = null;
                estadoOriginalSwitch = null;
            }
        });
    }

    // paginação da tabela de produtos 
    function atualizarPaginacao() {
        const paginacaoContainer = document.querySelector('.btn-toolbar .btn-group');
        paginacaoContainer.innerHTML = '';
        for (let i = 0; i < totalPaginas; i++) {
            const button = document.createElement('button');
            button.type = 'button';
            button.className = 'btn btn-outline-secondary';
            button.textContent = i + 1;
            button.addEventListener('click', function() {
                paginaAtual = i;
                carregarProdutos(paginaAtual);
            });
            paginacaoContainer.appendChild(button);
        }
    }

    // Controle da página (mantém as funções para alternar entre usuários e produtos)
    function showUsuarios() {
        document.getElementById('tabelaUsuarios').classList.remove('d-none');
        document.getElementById('tabelaProdutos').classList.add('d-none');
        document.getElementById('tituloTabela').innerText = 'Usuários';
        document.getElementById('botaoNovo').innerText = '+ Novo Usuário';
        document.getElementById('paginas123').classList.add('d-none');

        document.getElementById('barraDePesquisa').classList.add('d-none'); // Esconde a barra de pesquisa

        carregarUsuarios();
    }

    function showProdutos() {
        document.getElementById('tabelaUsuarios').classList.add('d-none');
        document.getElementById('tabelaProdutos').classList.remove('d-none');
        document.getElementById('tituloTabela').innerText = 'Produtos';
        document.getElementById('botaoNovo').innerText = '+ Novo Produto';
        document.getElementById('paginas123').classList.remove('d-none');

        document.getElementById('barraDePesquisa').classList.remove('d-none'); // Mostra a barra de pesquisa

        carregarProdutos();
    }

    window.showUsuarios = showUsuarios;
    window.showProdutos = showProdutos;

    // Carregar usuários automaticamente ao carregar a página
    carregarUsuarios();
    // obtem o usuario logado
    obterUsuarioLogado();

    /* Alertas e erros */ 
    // Função para exibir mensagem de erro na div de alerta
    function exibirErro(mensagem) {
        var errorDiv = document.querySelector('.alert-danger');
        errorDiv.querySelector('strong').textContent = mensagem;
        errorDiv.classList.remove('visually-hidden');
        setTimeout(function () {
            errorDiv.classList.add('visually-hidden');
        }, 3000);
    }
    // Verificar se deve exibir o toast
    if (localStorage.getItem('showUserToast') === 'true') {
        var toastEl = document.getElementById('userToast');
        var toast = new bootstrap.Toast(toastEl);
        toast.show();

        // Remover o valor do localStorage para não exibir novamente
        localStorage.removeItem('showUserToast');
    }
    // error toast
    function exibirErroToast(mensagem) {
        var errorToast = new bootstrap.Toast(document.getElementById('errorToast'));
        document.querySelector('#errorToast .toast-body').textContent = mensagem;
        errorToast.show();
    }

    /* Validação */
    // Função para validar email
    function validarEmail(email) {
        var regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    }
    // Função para validar CPF
    function validarCPF(cpf) {
        cpf = cpf.replace(/[^\d]+/g, '');
        if (cpf.length !== 11) return false;
        if (/^(\d)\1+$/.test(cpf)) return false;
        let soma = 0;
        for (let i = 0; i < 9; i++) soma += parseInt(cpf.charAt(i)) * (10 - i);
        let resto = 11 - (soma % 11);
        if (resto === 10 || resto === 11) resto = 0;
        if (resto !== parseInt(cpf.charAt(9))) return false;
        soma = 0;
        for (let i = 0; i < 10; i++) soma += parseInt(cpf.charAt(i)) * (11 - i);
        resto = 11 - (soma % 11);
        if (resto === 10 || resto === 11) resto = 0;
        return resto === parseInt(cpf.charAt(10));
    }
    // Função para obter o usuário logado
    async function obterUsuarioLogado() {
        try {
            const response = await fetch('http://localhost:8080/api/auth/me', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'include' // Inclui cookies na requisição
            });

            if (!response.ok) {
                throw new Error('Erro ao obter usuário logado');
            }

            const data = await response.json();
            usuarioLogadoId = data.id;

            // Verifica o grupo do usuário
            if (data.grupo === "ESTOQUISTA") {
                // Esconde a opção de usuários no menu lateral
                document.getElementById('linkUsuarios').classList.add('d-none');

                // Mostra apenas a tabela de produtos
                document.getElementById('tabelaUsuarios').classList.add('d-none');
                document.getElementById('tabelaProdutos').classList.remove('d-none');
                document.getElementById('tituloTabela').innerText = 'Produtos';
                document.getElementById('botaoNovo').innerText = '+ Novo Produto';
                document.getElementById('paginas123').classList.remove('d-none');

                document.getElementById('barraDePesquisa').classList.remove('d-none'); // Mostra a barra de pesquisa caso o usuario logado seja estoquista

                carregarProdutos();
            } else if (data.grupo === "ADMINISTRADOR") {
                // Mostra a tabela de usuários por padrão para administradores
                carregarUsuarios();
            }
        } catch (error) {
            console.error('Erro:', error);
        }
    }
    // Log para indicar que o script foi carregado com sucesso
    (function () {
        const scriptName = document.currentScript.src.split('/').pop();
        console.log(`${scriptName} carregado com sucesso`);
    })();
});