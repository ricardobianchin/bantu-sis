unit App.UI.Form.TabSheet.Retag.Aju.BemVindo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, App.AppInfo;

type
  TRetagAjuBemVindoForm = class(TTabSheetAppBasForm)
    SaudacaoLabel: TLabel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    procedure InicieControles;
    procedure InicieSaudacao;
  protected
    function GetTitulo: string; override;
  public
    { Public declarations }
  end;

var
  RetagAjuBemVindoForm: TRetagAjuBemVindoForm;

implementation

{$R *.dfm}

uses Sis.Types.Times;

{ TRetagAjuBemVindoForm }

function TRetagAjuBemVindoForm.GetTitulo: string;
begin
  Result := 'Bem-Vindo';
end;

procedure TRetagAjuBemVindoForm.InicieControles;
begin
  InicieSaudacao;
end;

procedure TRetagAjuBemVindoForm.InicieSaudacao;
var
  vAgora: TDateTime;
  sCaption: string;
begin
  vAgora := Now;
  sCaption := DateTimeToSaudacao(vAgora);
  SaudacaoLabel.Caption := sCaption;
end;

procedure TRetagAjuBemVindoForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  InicieControles;
end;

end.
