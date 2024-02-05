unit App.UI.Form.TabSheet.Retag.Aju.BemVindo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.TabSheet_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls;

type
  TRetagAjuBemForm = class(TTabSheetBasForm)
    SaudacaoLabel: TLabel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    procedure InicieControles;
    procedure InicieSaudacao;
  public
    { Public declarations }
  end;

var
  RetagAjuBemForm: TRetagAjuBemForm;

implementation

{$R *.dfm}

uses Sis.Types.Times;

procedure TRetagAjuBemForm.InicieControles;
begin
  InicieSaudacao;
end;

procedure TRetagAjuBemForm.InicieSaudacao;
var
  vAgora: TDateTime;
  sCaption: string;
begin
  vAgora := Now;
  sCaption := DateTimeToSaudacao(vAgora);
  SaudacaoLabel.Caption := sCaption;
end;

procedure TRetagAjuBemForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  InicieControles;
end;

end.
