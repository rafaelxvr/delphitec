unit Model.Produto;

interface

uses
  Data.DB, FireDAC.Comp.Client, Model.Interfaces;

type
  TModelProduto = class(TInterfacedObject, IModelProduto)
  private
    F_produtoId: Integer;
    F_produtoNome: String;
    F_produtoDescricao: string;
    F_produtoValor: Double;
    F_produtoQuantidade: Double;
    F_categoriaId: Integer;
    function GetcategoriaId: Integer;
    function GetprodutoDescricao: string;
    function GetprodutoId: Integer;
    function GetprodutoNome: string;
    function GetprodutoQuantidade: Double;
    function GetprodutoValor: Double;
    procedure SetcategoriaId(const Value: Integer);
    procedure SetprodutoDescricao(const Value: string);
    procedure SetprodutoId(const Value: Integer);
    procedure SetprodutoNome(const Value: string);
    procedure SetprodutoQuantidade(const Value: Double);
    procedure SetprodutoValor(const Value: Double);
  published
    property produtoId        :Integer    read GetprodutoId      write SetprodutoId;
    property produtoNome      :string     read GetprodutoNome           write SetprodutoNome;
    property produtoDescricao :string     read GetprodutoDescricao      write SetprodutoDescricao;
    property produtoValor     :Double     read GetprodutoValor          write SetprodutoValor;
    property produtoQuantidade:Double     read GetprodutoQuantidade     write SetprodutoQuantidade;
    property categoriaId      :Integer    read GetcategoriaId    write SetcategoriaId;
  end;

implementation

uses
  System.SysUtils;


{ TCategoria }

{$region 'Constructor and Destructor'}

function TModelProduto.GetcategoriaId: Integer;
begin
  Result := F_categoriaId;
end;

function TModelProduto.GetprodutoDescricao: string;
begin
  Result := F_produtoDescricao;
end;

function TModelProduto.GetprodutoId: Integer;
begin
  Result := F_produtoId;
end;

function TModelProduto.GetprodutoNome: string;
begin
  Result := F_produtoNome;
end;

function TModelProduto.GetprodutoQuantidade: Double;
begin
  Result := F_produtoQuantidade;
end;

function TModelProduto.GetprodutoValor: Double;
begin
  Result := F_produtoValor;
end;

procedure TModelProduto.SetcategoriaId(const Value: Integer);
begin
  F_categoriaId := Value;
end;

procedure TModelProduto.SetprodutoDescricao(const Value: string);
begin
  F_produtoDescricao := Value;
end;

procedure TModelProduto.SetprodutoId(const Value: Integer);
begin
  F_produtoId := Value;
end;

procedure TModelProduto.SetprodutoNome(const Value: string);
begin
  F_produtoNome := Value;
end;

procedure TModelProduto.SetprodutoQuantidade(const Value: Double);
begin
  F_produtoQuantidade := Value;
end;

procedure TModelProduto.SetprodutoValor(const Value: Double);
begin
  F_produtoValor := Value;
end;

{$endRegion}

end.
