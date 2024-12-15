unit App.UI.Form.Ed.CxOperacao_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI;

type
  TCxOperacaoEdForm = class(TEdBasForm)
    MeioPanel: TPanel;
    CupomPanel: TPanel;
    TrabPanel: TPanel;
    ObsPanel: TPanel;
    Label2: TLabel;
    ObsMemo: TMemo;
    Label1: TLabel;
    CupomListBox: TListBox;
  private
    { Private declarations }
    FCxOperacaoEnt: ICxOperacaoEnt;
    FCxOperacaoDBI: ICxOperacaoDBI;
  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
    function GravouOk: boolean; override;
    procedure AjusteTabOrder; virtual;
    property CxOperacaoEnt: ICxOperacaoEnt read FCxOperacaoEnt;
    property CxOperacaoDBI: ICxOperacaoDBI read FCxOperacaoDBI;


  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  CxOperacaoEdForm: TCxOperacaoEdForm;

implementation

{$R *.dfm}

uses System.Math, App.Est.Venda.CaixaSessao.Factory_u;

{ TCxOperacaoEdForm }

procedure TCxOperacaoEdForm.AjusteControles;
begin
  inherited;

end;

procedure TCxOperacaoEdForm.AjusteTabOrder;
begin

end;

function TCxOperacaoEdForm.ControlesOk: boolean;
begin
  Result := True;
end;

procedure TCxOperacaoEdForm.ControlesToEnt;
begin
  FCxOperacaoEnt.Obs := ObsMemo.Lines.Text;
end;

constructor TCxOperacaoEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited Create(AOwner, pAppObj, pEntEd, pEntDBI);
  FCxOperacaoEnt := EntEdCastToCxOperacaoEnt(pEntEd);
  Height := Min(1000, Screen.WorkAreaRect.Height - 10);
  Width := 900;

end;

function TCxOperacaoEdForm.DadosOk: boolean;
begin
  Result := True;
end;

procedure TCxOperacaoEdForm.EntToControles;
begin
  ObsMemo.Lines.Text := FCxOperacaoEnt.Obs;
end;

function TCxOperacaoEdForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sVal: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := EntEd.NomeEnt;
  sVal := '';

//  sFormat := '%s %s: %s';
//  Result := Format(sFormat, [sTit, sNom, sVal]);
  Result := sNom;
end;

function TCxOperacaoEdForm.GravouOk: boolean;
begin
  Result := EntDBI.Gravar;
end;

end.
