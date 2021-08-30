unit DMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, Vcl.Dialogs, IniFiles, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfmDM = class(TDataModule)
    Connection: TFDConnection;
    DriverLink: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    tbAux: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure TentarCriarDatabase;
    procedure TentarCriarTabelasERegistros;
    function TabelaExiste(aNomeTabela: String): Boolean;
    procedure ExecutaDiretoDB(aScript: String);
  public
  end;

var
  fmDM: TfmDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TfmDM.DataModuleCreate(Sender: TObject);
var
  Arquivo: TIniFile;
  Caminho,
  BibliotecaMysql: string;
begin
  Caminho := ExtractFilePath(ParamStr(0));
  BibliotecaMysql := Caminho + 'libmysql.dll';
//  fmDM.DriverLink.VendorHome := ExtractFilePath(BibliotecaMysql);
  fmDM.DriverLink.VendorLib := ExtractFileName(BibliotecaMysql);
  Arquivo := TIniFile.Create(Caminho + 'db.ini');
  try
    try
      Connection.Connected := False;
      Connection.Params.Values['Server'] := Arquivo.ReadString('PROJ', 'Server', 'localhost');
      Connection.Params.Values['Database'] := '';
      Connection.Params.Values['Username'] := Arquivo.ReadString('PROJ', 'Username', 'root');
      Connection.Params.Values['Password'] := Arquivo.ReadString('PROJ', 'Password', '6511');
      Connection.Params.Values['Port'] := Arquivo.ReadString('PROJ', 'Port', '3306');
      Connection.Connected := True;
      if Connection.Connected then
        TentarCriarDatabase;

      Connection.Connected := False;
      Connection.Params.Values['Database'] := Arquivo.ReadString('PROJ', 'Database', 'delphitec');
      Connection.Connected := True;
      if Connection.Connected then
        TentarCriarTabelasERegistros;
    except
      on E: Exception do
        ShowMessage('Erro ao se conectar ao banco de dados! Detalhes: '+e.Message);
    end;
  finally
    FreeAndNil(Arquivo);
  end;
end;

procedure TfmDM.TentarCriarDatabase;
begin
  tbAux.SQL.Clear;
  tbAux.SQL.Text := 'CREATE DATABASE IF NOT EXISTS delphitec';
  tbAux.ExecSQL;
end;

procedure TfmDM.TentarCriarTabelasERegistros;
begin
  if not TabelaExiste('categorias') then
  begin
        ExecutaDiretoDB('CREATE TABLE categorias ('+
        'categoriaId int AUTO_INCREMENT NOT NULL,'+
        'categoriaDescricao  varchar(30) NULL,'+
        'PRIMARY KEY (categoriaId)'+
        '	) '
        );
  end;

  if not TabelaExiste('produtos') then
  begin
        ExecutaDiretoDB('CREATE TABLE produtos( '+
        ' produtoId int AUTO_INCREMENT NOT NULL, '+
        ' produtoNome varchar(60) NULL, '+
        ' produtoDescricao varchar(255) null, '+
        ' produtoValor decimal(18,5) default 0.00000 null, '+
        ' produtoQuantidade int DEFAULT 0 NULL, '+
        ' categoriaId int null, '+
        ' PRIMARY KEY (produtoId), '+
        ' CONSTRAINT FK_ProdutosCategorias '+
        ' FOREIGN KEY (categoriaId) references categorias(categoriaId '+
        '	) '
        );
  end;

  if not TabelaExiste('clientes') then
  begin
        ExecutaDiretoDB('CREATE TABLE IF NOT EXISTS clientes('+
       'clienteId int AUTO_INCREMENT NOT NULL, '+
       'clienteNome varchar(60) NULL, '+
	     'clienteCidade varchar(50) null, '+
	     'clienteUF varchar(2) NULL, '+
       'PRIMARY KEY (clienteId) '+
       '	) '
       );
  end;

  if not TabelaExiste('vendas') then
  begin
        ExecutaDiretoDB('CREATE TABLE IF NOT EXISTS vendas('+
         ' vendaId int AUTO_INCREMENT not null, '+
         ' clienteId int not null, '+
         ' dataVenda datetime, '+
         ' totalVenda decimal(18,5) DEFAULT 0, '+
         ' PRIMARY KEY (vendaId), '+
         ' CONSTRAINT FK_VendasClientes FOREIGN KEY (clienteId)'+
         ' REFERENCES clientes(clienteId)'+
         '	) '
         );
  end;

  if not TabelaExiste('vendasitens') then
  begin
        ExecutaDiretoDB('CREATE TABLE IF NOT EXISTS vendasitens( '+
        ' vendaId int AUTO_INCREMENT NOT NULL, '+
        ' produtoId int not null, '+
        ' itensValorUnitario decimal (18,5) default 0.00000, '+
        ' itensQuantidade decimal (18,5) default 0.00000, '+
        ' itensTotalProduto decimal (18,5) default 0.00000, '+
        ' PRIMARY KEY (vendaId,produtoId), '+
        ' CONSTRAINT FK_VendasItensProdutos FOREIGN KEY (produtoId) '+
        ' REFERENCES produtos(produtoId)'+
        '	) '
        );
  end;
end;

function TfmDM.TabelaExiste(aNomeTabela: String): Boolean;
Begin
  Try
    Result:=False;
    tbAux.SQL.Clear;
    tbAux.SQL.Text :=
      ' SELECT COUNT(*) ' +
        ' FROM information_schema.tables ' +
        ' WHERE table_schema = ''delphitec'' ' +
        ' AND table_name=:NomeTabela ';
    tbAux.ParamByName('NomeTabela').AsString := aNomeTabela;
    tbAux.Open;
    Result := True;
  Finally
    tbAux.Close;
  End;
end;

procedure TfmDM.DataModuleDestroy(Sender: TObject);
begin
      if Assigned(tbAux) then
       FreeAndNil(tbAux);
end;

procedure TfmDM.ExecutaDiretoDB(aScript : String);
begin
    tbAux.SQL.Clear;
    tbAux.SQL.Add(aScript);
  try
    tbAux.ExecSQL;
  finally
    tbAux.Close;
    if Assigned(tbAux) then
       FreeAndNil(tbAux);
  end;
end;

end.
