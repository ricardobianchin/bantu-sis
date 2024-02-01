unit App.UI.Sessao.Select.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, App.UI.Sessao.Select.DBGrid.Frame,
  App.Constants;

type
  TSessaoSelectForm = class(TDiagBtnBasForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FSessaoSelectDBGridFrame: TSessaoSelectDBGridFrame;
  public
    { Public declarations }
  end;

function SessaoSelect(pSessaoIndexOrigem: TSessaoIndex): boolean;

var
  SessaoSelectForm: TSessaoSelectForm;

implementation

{$R *.dfm}

function SessaoSelect(pSessaoIndexOrigem: TSessaoIndex): boolean;
begin
  Result := False;
end;

procedure TSessaoSelectForm.FormCreate(Sender: TObject);
begin
  inherited;
  FSessaoSelectDBGridFrame := TSessaoSelectDBGridFrame.Create(Self);
  FSessaoSelectDBGridFrame.Align := alClient;

end;

end.
