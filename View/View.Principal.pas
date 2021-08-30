unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Controller.Interfaces, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Imaging.pngimage, RxCurrEdit,
  Vcl.Mask, RxToolEdit, View.ScreenControl.Principal, View.Processo.Vendas;

type
  TfrmPrincipal = class(TForm)
    pnlFull: TPanel;
    Panel1: TPanel;
    pnlBottom: TPanel;
    spbFecharTela: TSpeedButton;
    imgLogo: TImage;
    procedure spbFecharTelaClick(Sender: TObject);
    procedure imgLogoClick(Sender: TObject);
  private
  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.imgLogoClick(Sender: TObject);
begin
  Application.CreateForm(TViewProcessoVendas, ViewProcessoVendas);
  try
    ViewProcessoVendas.ShowModal;
  finally
    ViewProcessoVendas.Release;
  end;
end;

procedure TfrmPrincipal.spbFecharTelaClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
