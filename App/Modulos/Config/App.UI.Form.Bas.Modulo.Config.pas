unit App.UI.Form.Bas.Modulo.Config;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.Menus;

type
  TConfigModuloBasForm = class(TModuloBasForm)
    TopoPanel: TPanel;
    MenuPageControl: TPageControl;
    ImportTabSheet: TTabSheet;
    ImportOrigemComboBox: TComboBox;
    ImportOrigemTitLabel: TLabel;
  private
    { Private declarations }
  protected
    procedure ImportPrepForm; virtual;
  public
    { Public declarations }
  end;

var
  ConfigModuloBasForm: TConfigModuloBasForm;

implementation

{$R *.dfm}

{ TConfigModuloBasForm }

procedure TConfigModuloBasForm.ImportPrepForm;
begin
  ImportOrigemComboBox.Text := '';
  ImportOrigemComboBox.Clear;
end;

end.
