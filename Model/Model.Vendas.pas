unit Model.Vendas;

interface

uses
  Model.Interfaces,
  View.ScreenControl.Principal,
  Data.DB,
  FireDAC.Comp.Client,
  Model.ControleEstoque.SQL;

type
  TModelVendas = class(TInterfacedObject, IModelVenda)
  private
    F_vendaId:Integer;
    F_clienteId:Integer;
    F_dataVenda:TDateTime;
    F_totalVenda: Double;
    function GetclienteId: Integer;
    function GetdataVenda: TDateTime;
    function GettotalVenda: Double;
    function GetvendaId: Integer;
    procedure SetclienteId(const Value: Integer);
    procedure SetdataVenda(const Value: TDateTime);
    procedure SettotalVenda(const Value: Double);
    procedure SetvendaId(const Value: Integer);
  published
    property VendaId:Integer read GetvendaId    write SetvendaId;
    property ClienteId:Integer   read GetclienteId  write SetclienteId;
    property DataVenda:TDateTime read GetdataVenda  write SetdataVenda;
    property TotalVenda:Double   read GettotalVenda write SettotalVenda;
  end;

implementation

uses
  Vcl.Dialogs, System.SysUtils;

procedure TModelVendas.SetclienteId(const Value: Integer);
begin
  F_clienteId := Value;
end;

procedure TModelVendas.SetdataVenda(const Value: TDateTime);
begin
  F_dataVenda := Value;
end;

procedure TModelVendas.SettotalVenda(const Value: Double);
begin
  F_totalVenda := Value;
end;

procedure TModelVendas.SetvendaId(const Value: Integer);
begin
  F_vendaId := Value;
end;

function TModelVendas.GetclienteId: Integer;
begin
  Result := F_clienteId;
end;

function TModelVendas.GetdataVenda: TDateTime;
begin
  Result := F_dataVenda;
end;

function TModelVendas.GettotalVenda: Double;
begin
  Result := F_totalVenda;
end;

function TModelVendas.GetvendaId: Integer;
begin
  Result := F_vendaId;
end;

end.
