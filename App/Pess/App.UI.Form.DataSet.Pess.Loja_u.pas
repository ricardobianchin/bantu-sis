unit App.UI.Form.DataSet.Pess.Loja_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.DataSet.Pess_u, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin;

type
  TAppPessLojaDataSetForm = class(TAppPessDataSetForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AppPessLojaDataSetForm: TAppPessLojaDataSetForm;

implementation

{$R *.dfm}

procedure TAppPessLojaDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
//
end;

end.
