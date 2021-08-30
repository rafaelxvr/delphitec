unit Model.Conexao.FiredacQuery;

interface

uses
  FireDAC.Comp.Client, Model.Conexao.Interfaces, Data.DB;

type
  TModelConexaoFiredacQuery = class(TInterfacedObject, iModelQuery)
  private
    FQuery : TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iModelQuery;
    function Query : TDataSet;
  end;

implementation

{ TModelConexaoFiredacQuery }

constructor TModelConexaoFiredacQuery.Create;
begin
  FQuery := TFDQuery.Create(nil);
end;

destructor TModelConexaoFiredacQuery.Destroy;
begin
  FQuery.DisposeOf;
  inherited;
end;

class function TModelConexaoFiredacQuery.New: iModelQuery;
begin
  Result := Self.Create;
end;

function TModelConexaoFiredacQuery.Query: TDataSet;
begin
  Result := FQuery;
end;

end.
