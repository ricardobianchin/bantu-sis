unit App.UI.Form.DataSet.Pess_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin;

type
  TAppPessDataSetForm = class(TTabSheetDataSetBasForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AppPessDataSetForm: TAppPessDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

procedure TAppPessDataSetForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ClearStyleElements(Self);
end;

end.
