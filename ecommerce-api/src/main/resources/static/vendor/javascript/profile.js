document.addEventListener("DOMContentLoaded", function () {
    let userId = null;

    // Função para carregar e exibir o perfil do usuário
    async function carregarPerfil() {
        try {
            const response = await fetch('/api/auth/me', {
                method: 'GET',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'include'
            });

            if (!response.ok) throw new Error('Erro ao carregar perfil');
            const data = await response.json();

            userId = data.id;

            if (data.grupo !== 'CLIENTE') {
                window.location.href = '/backoffice';
                return;
            }

            atualizarPerfilDOM(data);
            preencherModal(data);
        } catch (error) {
            console.error('Erro:', error);
        }
    }

    // Função para atualizar o DOM com os dados do perfil
    function atualizarPerfilDOM(data) {      
        function formatarData(dataString) {
            const data = new Date(dataString);
            const dia = String(data.getDate()).padStart(2, '0');
            const mes = String(data.getMonth() + 1).padStart(2, '0');
            const ano = data.getFullYear();
            return `${dia}/${mes}/${ano}`;
        }

        document.querySelector('.userNome').textContent = data.nomeCompleto;
        document.querySelector('.userEmail').textContent = data.email;
        document.querySelector('.userEmailSec').textContent = data.emailSecundario;
        document.querySelector('.userGenero').textContent = data.genero;
        document.querySelector('.userNascimento').textContent = formatarData(data.dataNascimento);
        document.querySelector('.userGrup').textContent = data.grupo;
    }

    // Função para preencher o modal com os dados atuais do usuário
    function preencherModal(data) {
        document.getElementById('nome').value = data.nomeCompleto;
        document.getElementById('dataNascimento').value = data.dataNascimento;

        if (data.genero === 'Masculino') {
            document.getElementById('Masculino').checked = true;
        } else if (data.genero === 'Feminino') {
            document.getElementById('Feminino').checked = true;
        }
    }

    // Função para exibir o toast de sucesso ou erro
    function mostrarToast(tipo) {
        const toastEl = document.getElementById(tipo === 'sucesso' ? 'successToast' : 'errorToast');
        const toast = new bootstrap.Toast(toastEl);
        toast.show();
    }

    // Função para limpar os campos do modal de dados pessoais
    function limparCamposModal() {
        document.getElementById('nome').value = '';
        document.getElementById('dataNascimento').value = '';
        document.querySelectorAll('input[name="inlineRadioOptions"]').forEach(input => input.checked = false);
    }

    // Função para limpar os campos do modal de senha
    function limparCamposModalSenha() {
        document.getElementById('senha').value = '';
        document.getElementById('confirmarSenha').value = '';
    }

    // Função para atualizar os dados pessoais
    async function atualizarDadosPessoais() {
        const nomeCompleto = document.getElementById('nome').value;
        const dataNascimento = document.getElementById('dataNascimento').value;
        const genero = document.querySelector('input[name="inlineRadioOptions"]:checked')?.value || '';

        try {
            const perfilAtual = await fetch(`/api/clientes/${userId}`, {
                method: 'GET',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'include'
            }).then(res => res.json());

            const payload = {
                id: userId,
                nomeCompleto: nomeCompleto || perfilAtual.nomeCompleto,
                dataNascimento: dataNascimento || perfilAtual.dataNascimento,
                genero: genero || perfilAtual.genero,
                email: perfilAtual.email,
                cpf: perfilAtual.cpf,
                emailSecundario: perfilAtual.emailSecundario,
                senha: perfilAtual.senha,
                grupo: perfilAtual.grupo,
                ativo: perfilAtual.ativo 
            };

            const response = await fetch(`/api/clientes/${userId}`, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'include',
                body: JSON.stringify(payload)
            });

            if (!response.ok) throw new Error('Erro ao atualizar dados pessoais');
            
            mostrarToast('sucesso');
            limparCamposModal();

            const modal = bootstrap.Modal.getInstance(document.getElementById('modalEditProfile'));
            modal.hide();

            atualizarPerfilDOM(payload);
        } catch (error) {
            console.error('Erro:', error);
            mostrarToast('erro');
        }
    }

    // Função para alterar a senha
    async function alterarSenha() {
        const novaSenha = document.getElementById('senha').value;
        const confirmarSenha = document.getElementById('confirmarSenha').value;

        if (novaSenha !== confirmarSenha) {
            alert('As senhas não coincidem!');
            return;
        }

        try {
            const response = await fetch(`/api/clientes/${userId}/update-password?novaSenha=${encodeURIComponent(novaSenha)}`, {
                method: 'PATCH',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'include'
            });

            if (!response.ok) throw new Error('Erro ao alterar a senha');
            
            mostrarToast('sucesso');
            limparCamposModalSenha();

            const modal = bootstrap.Modal.getInstance(document.getElementById('modalEditSenhaProfile'));
            modal.hide();

        } catch (error) {
            console.error('Erro:', error);
            mostrarToast('erro');
        }
    }

    // Eventos
    document.querySelector('#modalEditProfile .btn-primary').addEventListener('click', atualizarDadosPessoais);
    document.querySelector('#modalEditSenhaProfile .btn-primary').addEventListener('click', alterarSenha);
    document.getElementById('modalEditProfile').addEventListener('hidden.bs.modal', limparCamposModal);
    document.getElementById('modalEditSenhaProfile').addEventListener('hidden.bs.modal', limparCamposModalSenha);

    // Carrega o perfil ao carregar a página
    carregarPerfil();
});
