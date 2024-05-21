CREATE TABLE Categorias (
    CategoriaID INT IDENTITY PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Descricao TEXT
);

--------------------------------------------------------------------------

CREATE TABLE Topicos (
    TopicoID INT IDENTITY PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Descricao TEXT
);

--------------------------------------------------------------------------

CREATE TABLE Cadastros (
    CadastroID INT IDENTITY PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Tipo VARCHAR(20) NOT NULL, -- ENUM: 'Funcionário', 'Cliente', 'Fornecedor', 'Corretor', 'Imobiliária', 'Investidor'
    Documento VARCHAR(20),
    Endereco TEXT,
    Telefone VARCHAR(15),
    Email VARCHAR(100),
    OutrosDetalhes TEXT
);

--------------------------------------------------------------------------

CREATE TABLE Contas (
    ContaID INT IDENTITY PRIMARY KEY,
    Tipo VARCHAR(20) NOT NULL, -- ENUM: 'Pagar', 'Receber'
    FormaPagamento VARCHAR(20) NOT NULL, -- ENUM: 'Boleto', 'Crédito', 'Pix'
    Valor DECIMAL(10, 2) NOT NULL,
    DataVencimento DATE NOT NULL,
    Status VARCHAR(20) NOT NULL, -- ENUM: 'Pendente', 'Pago'
    Descricao TEXT,
    TopicoID INT NOT NULL,
    CadastroID INT NOT NULL,
    FOREIGN KEY (TopicoID) REFERENCES Topicos(TopicoID),
    FOREIGN KEY (CadastroID) REFERENCES Cadastros(CadastroID)
);

--------------------------------------------------------------------------

CREATE TABLE ParcelasMensais (
    ParcelaID INT IDENTITY PRIMARY KEY,
    ClienteID INT NOT NULL,
    Valor DECIMAL(10, 2) NOT NULL,
    DataVencimento DATE NOT NULL,
    Status VARCHAR(20) NOT NULL, -- ENUM: 'Pendente', 'Pago'
    FOREIGN KEY (ClienteID) REFERENCES Cadastros(CadastroID)
);

--------------------------------------------------------------------------

CREATE TABLE Compras (
    CompraID INT IDENTITY PRIMARY KEY,
    FornecedorID INT NOT NULL,
    DataCompra DATE NOT NULL,
    ValorTotal DECIMAL(10, 2) NOT NULL,
    ArquivoXML TEXT,
    ArquivoPDF TEXT,
    FOREIGN KEY (FornecedorID) REFERENCES Cadastros(CadastroID)
);

--------------------------------------------------------------------------

CREATE TABLE Pedidos (
    PedidoID INT IDENTITY PRIMARY KEY,
    ClienteID INT NOT NULL,
    DataPedido DATE NOT NULL,
    ValorTotal DECIMAL(10, 2) NOT NULL,
    Status VARCHAR(20) NOT NULL, -- ENUM: 'Aberto', 'Fechado'
    FOREIGN KEY (ClienteID) REFERENCES Cadastros(CadastroID)
);

--------------------------------------------------------------------------

CREATE TABLE NotasFiscais (
    NotaID INT IDENTITY PRIMARY KEY,
    PedidoID INT NOT NULL,
    NumeroNF VARCHAR(50) NOT NULL,
    DataEmissao DATE NOT NULL,
    ValorTotal DECIMAL(10, 2) NOT NULL,
    ArquivoPDF TEXT,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID)
);

--------------------------------------------------------------------------

CREATE TABLE Contratos (
    ContratoID INT IDENTITY PRIMARY KEY,
    CadastroID INT NOT NULL,
    Tipo VARCHAR(20) NOT NULL, -- ENUM: 'Cliente', 'Terceiro', 'Imóvel'
    DataInicio DATE NOT NULL,
    DataFim DATE,
    ArquivoPDF TEXT,
    FOREIGN KEY (CadastroID) REFERENCES Cadastros(CadastroID)
);

--------------------------------------------------------------------------

CREATE TABLE Projetos (
    ProjetoID INT IDENTITY PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    DataInicio DATE NOT NULL,
    DataFim DATE,
    ArquivoPDF TEXT,
    ConstrutoraID INT NOT NULL,
    FOREIGN KEY (ConstrutoraID) REFERENCES Cadastros(CadastroID)
);

--------------------------------------------------------------------------

CREATE TABLE FluxoDeCaixa (
    FluxoID INT IDENTITY PRIMARY KEY,
    Data DATE NOT NULL,
    SaldoInicial DECIMAL(10, 2) NOT NULL,
    Entradas DECIMAL(10, 2) NOT NULL,
    Saidas DECIMAL(10, 2) NOT NULL,
    SaldoFinal DECIMAL(10, 2) NOT NULL,
    CategoriaID INT NOT NULL,
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);

--------------------------------------------------------------------------