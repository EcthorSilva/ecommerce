/*
* TO DO: 
* 
* - Usuarios
* 1. colocar uma validação para que o usuario logado não consiga desativar 
*    ele mesmo (endpoint /api/auth/me verifica o usuario logado);
* 2. (incompleto) fazer com que o botão de editar pegue as informações do usuario e coloque no modal para edição.
*
* - Produtos
* 1. colocar o modal de cadastro de produtos para funcionar, junto com a opção de adicionar
*    as imagens como no criterio de aceite do professor;
* 2. colocar o mesmo botão de ativação/desativação do usuario para o produto;
* 3. colocar o botão de editar para funcionar;
* 4. colocar o botão para visualizar o produto como nos criterios de aceite.
*/ 

document.addEventListener("DOMContentLoaded", function () {
    let usuarioSelecionado = null;

    let paginaAtual = 0;
    let totalPaginas = 0;

    let estadoOriginalSwitch = null;
    let switchElementAtual = null;

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

    async function carregarProdutos(pagina = 0) {
        try {
            const response = await fetch(`/api/produtos?page=${pagina}&size=10`);
            const data = await response.json();
            totalPaginas = data.totalPages;
            preencherTabelaProdutos(data.content);
            atualizarPaginacao();
        } catch (error) {
            console.error('Erro ao carregar produtos:', error);
        }
    }

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
                <button class="btn btn-outline-light editarUsuario" data-id="${usuario.id}">Editar</button>
            `;

            // Adiciona evento de clique ao botão "Editar"
            const editarBtn = row.querySelector(".editarUsuario");
            editarBtn.addEventListener("click", function () {
                abrirModalEdicao(usuario);
            });

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

    function abrirModalEdicao(usuario) {
        usuarioSelecionado = usuario;
        document.getElementById("usuarioId").value = usuario.id;
        document.getElementById("nomeUsuario").value = usuario.nome;
        document.getElementById("cpfUsuario").value = usuario.cpf;
        document.getElementById("emailUsuario").value = usuario.email;
        document.getElementById("grupoUsuario").value = usuario.grupo;
        document.getElementById("senhaUsuario").value = "";
        document.getElementById("confirmarSenhaUsuario").value = "";

        const modalUsuario = new bootstrap.Modal(document.getElementById("modalUsuario"));
        modalUsuario.show();
    }

    document.getElementById("salvarUsuario").addEventListener("click", async function () {
        const id = document.getElementById("usuarioId").value;
        const nome = document.getElementById("nomeUsuario").value;
        const cpf = document.getElementById("cpfUsuario").value;
        const email = document.getElementById("emailUsuario").value;
        const grupo = document.getElementById("grupoUsuario").value;
        const senha = document.getElementById("senhaUsuario").value;
        const confirmarSenha = document.getElementById("confirmarSenhaUsuario").value;

        if (!nome || !cpf || !email || !grupo || (!id && (!senha || !confirmarSenha))) {
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

        const dados = {
            id: id ? parseInt(id) : undefined,
            nome: nome,
            cpf: cpf,
            email: email,
            senha: senha ? btoa(senha) : undefined, // Simulação de criptografia, substitua por uma real
            grupo: grupo,
            ativo: true
        };

        if (id) {
            await atualizarUsuario(dados);
        } else {
            await registrarUsuario(dados);
        }
    });

    async function atualizarUsuario(dados) {
        try {
            const response = await fetch(`http://localhost:8080/api/usuarios/${dados.id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(dados)
            });

            if (!response.ok) {
                throw new Error('Erro ao atualizar usuário');
            }

            localStorage.setItem('showUserToast', 'true');
            location.reload();
        } catch (error) {
            console.error('Erro:', error);
            exibirErro('Erro ao atualizar usuário');
        }
    }

    function exibirModalConfirmacao(ativo) {
        const mensagem = ativo ? 'Deseja desativar este usuário?' : 'Deseja ativar este usuário?';
        document.getElementById('confirmacaoMensagem').innerText = mensagem;
        const confirmacaoModal = new bootstrap.Modal(document.getElementById('confirmacaoModal'));
        confirmacaoModal.show();
    }

    document.getElementById('confirmarAcao').addEventListener('click', async function () {
        if (usuarioIdParaAtualizar !== null && novoStatusUsuario !== null) {
            await atualizarStatusUsuario(usuarioIdParaAtualizar, novoStatusUsuario);
            usuarioIdParaAtualizar = null;
            novoStatusUsuario = null;
            const confirmacaoModal = bootstrap.Modal.getInstance(document.getElementById('confirmacaoModal'));
            confirmacaoModal.hide();
        }
    });

    // Adiciona evento de clique ao botão de cancelar do modal
    document.querySelector('#confirmacaoModal .btn-secondary').addEventListener('click', function () {
        if (switchElementAtual !== null && estadoOriginalSwitch !== null) {
            switchElementAtual.checked = estadoOriginalSwitch; // Restaura o estado original do switch
            switchElementAtual = null;
            estadoOriginalSwitch = null;
        }
    });

    async function atualizarStatusUsuario(id, status) {
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

    function preencherTabelaProdutos(produtos) {
        const tabelaProdutos = document.getElementById('tabelaProdutos').getElementsByTagName('tbody')[0];
        tabelaProdutos.innerHTML = '';
        produtos.forEach(produto => {
            const row = tabelaProdutos.insertRow();
            row.insertCell(0).innerText = produto.id;
            row.insertCell(1).innerText = produto.nome;
            row.insertCell(2).innerText = produto.quantidadeEmEstoque;
            row.insertCell(3).innerText = produto.preco;
            row.insertCell(4).innerText = produto.ativo ? 'Ativo' : 'Inativo';
            row.insertCell(5).innerHTML = `
                <button class="btn btn-outline-light">Alterar</button>
                <button class="btn btn-outline-light">Visualizar</button>
            `;
        });
    }

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

    function showUsuarios() {
        document.getElementById('tabelaUsuarios').classList.remove('d-none');
        document.getElementById('tabelaProdutos').classList.add('d-none');
        document.getElementById('tituloTabela').innerText = 'Usuários';
        document.getElementById('botaoNovo').innerText = '+ Novo Usuário';
        document.getElementById('paginas123').classList.add('d-none');

        carregarUsuarios();
    }

    function showProdutos() {
        document.getElementById('tabelaUsuarios').classList.add('d-none');
        document.getElementById('tabelaProdutos').classList.remove('d-none');
        document.getElementById('tituloTabela').innerText = 'Produtos';
        document.getElementById('botaoNovo').innerText = '+ Novo Produto';
        document.getElementById('paginas123').classList.remove('d-none');
        carregarProdutos();
    }

    window.showUsuarios = showUsuarios;
    window.showProdutos = showProdutos;

    // Carregar usuários automaticamente ao carregar a página
    carregarUsuarios();

    // validação
    (function () {
        const scriptName = document.currentScript.src.split('/').pop();
        console.log(`${scriptName} carregado com sucesso`);
    })();
});

// modal para cadastrar novo usuario
document.addEventListener("DOMContentLoaded", function () {
    function validarEmail(email) {
        var regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    }

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

    function exibirErro(mensagem) {
        var errorDiv = document.querySelector('.alert-danger');
        errorDiv.querySelector('strong').textContent = mensagem;
        errorDiv.classList.remove('visually-hidden');
        setTimeout(function () {
            errorDiv.classList.add('visually-hidden');
        }, 3000);
    }

    async function registrarUsuario(dados) {
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

    // Verificar se deve exibir o toast
    if (localStorage.getItem('showUserToast') === 'true') {
        var toastEl = document.getElementById('userToast');
        var toast = new bootstrap.Toast(toastEl);
        toast.show();

        // Remover o valor do localStorage para não exibir novamente
        localStorage.removeItem('showUserToast');
    }

    document.getElementById("salvarUsuario").addEventListener("click", async function () {
        const nome = document.getElementById("nomeUsuario").value;
        const cpf = document.getElementById("cpfUsuario").value;
        const email = document.getElementById("emailUsuario").value;
        const grupo = document.getElementById("grupoUsuario").value;
        const senha = document.getElementById("senhaUsuario").value;
        const confirmarSenha = document.getElementById("confirmarSenhaUsuario").value;

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

        await registrarUsuario(dados);
    });
});