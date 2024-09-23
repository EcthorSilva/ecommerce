function showProdutos() {
    document.getElementById('tituloTabela').innerText = 'Produtos';
    document.getElementById('botaoNovo').innerText = '+ Novo Produto';
    document.getElementById('tabelaProdutos').classList.remove('d-none');
    document.getElementById('tabelaUsuarios').classList.add('d-none');

    document.getElementById('linkProdutos').classList.add('active');
    document.getElementById('linkUsuarios').classList.remove('active');
}

function showUsuarios() {
    document.getElementById('tituloTabela').innerText = 'Usuários';
    document.getElementById('botaoNovo').innerText = '+ Novo Usuário';
    document.getElementById('tabelaProdutos').classList.add('d-none');
    document.getElementById('tabelaUsuarios').classList.remove('d-none');

    document.getElementById('linkProdutos').classList.remove('active');
    document.getElementById('linkUsuarios').classList.add('active');
}