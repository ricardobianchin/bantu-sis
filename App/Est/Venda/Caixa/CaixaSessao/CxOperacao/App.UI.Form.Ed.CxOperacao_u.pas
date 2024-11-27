unit App.UI.Form.Ed.CxOperacao_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TCxOperacaoEdForm = class(TEdBasForm)
  private
    { Private declarations }
  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
    function GravouOk: boolean; override;
    procedure AjusteTabOrder; virtual;

    function NomeFantasiaOk: boolean; virtual;
    function ApelidoOk: boolean; virtual;
  public
    { Public declarations }
  end;

var
  CxOperacaoEdForm: TCxOperacaoEdForm;

implementation

{$R *.dfm}

{ TCxOperacaoEdForm }

procedure TCxOperacaoEdForm.AjusteControles;
begin
  inherited;

end;

procedure TCxOperacaoEdForm.AjusteTabOrder;
begin

end;

function TCxOperacaoEdForm.ApelidoOk: boolean;
begin

end;

function TCxOperacaoEdForm.ControlesOk: boolean;
begin

end;

procedure TCxOperacaoEdForm.ControlesToEnt;
begin
  inherited;

end;

function TCxOperacaoEdForm.DadosOk: boolean;
begin

end;

procedure TCxOperacaoEdForm.EntToControles;
begin
  inherited;

end;

function TCxOperacaoEdForm.GetObjetivoStr: string;
begin

end;

function TCxOperacaoEdForm.GravouOk: boolean;
begin

end;

function TCxOperacaoEdForm.NomeFantasiaOk: boolean;
begin

end;

end.
