unit Model.Conexao.Table.Firedac;

interface

uses
  Model.Conexao.Interfaces, FireDAC.Comp.Client, System.Classes;

Type
    TModelConexaoTableFiredac = class(TInterfacedObject, iModelDataSet)
    private
      FTable: TFDTable;
    public
      constructor Create(Conexao: IModelConexaoFactory);
      destructor Destroy; override;
      class function New(Conexao: IModelConexaoFactory): IModelDataSet;
      function Open(aTable: String): IModelDataSet;
      function EndDataSet: TComponent;
    end;

implementation

constructor TModelConexaoTableFiredac.Create(Conexao: IModelConexaoFactory);
begin
  FTable := TFDTable.Create(nil);
  FTable.Connection := (Conexao.Conexao.Connection as TFDConnection);
end;

destructor TModelConexaoTableFiredac.Destroy;
begin
  FTable.Free;
  inherited;
end;

function TModelConexaoTableFiredac.EndDataSet: TComponent;
begin
    Result := FTable;
end;

class function TModelConexaoTableFiredac.New(Conexao: IModelConexaoFactory): IModelDataSet;
begin
  Result := Self.Create(Conexao);
end;

function TModelConexaoTableFiredac.Open(aTable: String): iModelDataSet;
begin
  Result := Self;
  FTable.Open(aTable);
end;

end.
