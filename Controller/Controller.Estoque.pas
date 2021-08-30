unit Controller.Estoque;

interface

uses
  System.Generics.Collections, System.Sysutils, Controller.Interfaces, Data.DB,
  FireDAC.Comp.Client, Model.Interfaces, Model.ControleEstoque.SQL, DAO.Interfaces;

type
  TControllerEstoque = class(TInterfacedObject, IControllerEstoque)
  private
    FConexao: IConexao;
  public
    function BaixarEstoque(AEstoque: IModelEstoque): IModelEstoque;
    function RetornarEstoque(AEstoque: IModelEstoque): IModelEstoque;
    procedure AfterConstruction; override;
  end;

implementation

procedure TControllerEstoque.AfterConstruction;
begin
  inherited;
  FConexao := CreateConnection;
end;

function TControllerEstoque.BaixarEstoque(AEstoque: IModelEstoque): IModelEstoque;
var
  EstoqueDS: TFDQuery;
begin
  EstoqueDS := TFDQuery.Create(nil);
  try
    FConexao.ConfiguraTabela(EstoqueDS);
    EstoqueDS.SQL.Clear;
    EstoqueDS.SQL.Add('UPDATE produtos '+
                '   SET produtoQuantidade = produtoQuantidade - :qtdeBaixa '+
                ' WHERE produtoId=:produtoId ');
    EstoqueDS.ParamByName('produtoId').AsInteger := AEstoque.produtoId;
    EstoqueDS.ParamByName('qtdeBaixa').AsFloat   := AEstoque.produtoQuantidade;
    EstoqueDS.ExecSQL;

    Result := AEstoque;
  finally
    FreeAndNil(EstoqueDS);
  end;
end;

function TControllerEstoque.RetornarEstoque(AEstoque: IModelEstoque): IModelEstoque;
var
  EstoqueDS: TFDQuery;
begin
  EstoqueDS := TFDQuery.Create(nil);
  try
    FConexao.ConfiguraTabela(EstoqueDS);
    EstoqueDS.SQL.Clear;
    EstoqueDS.SQL.Add('UPDATE produtos '+
                '   SET produtoQuantidade = produtoQuantidade + :qtdeRetorno '+
                ' WHERE produtoId=:produtoId ');
    EstoqueDS.ParamByName('produtoId').AsInteger := AEstoque.produtoId;
    EstoqueDS.ParamByName('qtdeRetorno').AsFloat := AEstoque.produtoQuantidade;
    EstoqueDS.ExecSQL;

    Result := AEstoque;
  finally
    FreeAndNil(EstoqueDS);
  end;
end;

end.
