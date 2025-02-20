unit App.PDV.Factory_u;

interface

uses Sis.Entities.Types, System.Classes, Sis.Types, App.PDV.UI.Gaveta,
  App.UI.PDV.Frame_u, Vcl.ComCtrls, Vcl.Controls, Vcl.ActnList, Vcl.Forms,
  App.PDV.VendaPag.List, App.PDV.VendaPag, Sis.Terminal, App.PDV.Obj,
  App.PDV.CupomEspelho, App.AppObj, Sis.UI.Impressao, App.PDV.Venda,
  App.PDV.ImpressaoTextoVenda_u, App.PDV.UI.Balanca, Sis.Usuario,
  App.PDV.UI.Balanca.VendaForm_u, App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent;

function PDVFrameAvisoCreate(pParent: TWinControl; pPDVObj: IPDVObj;
  pCaption: TCaption; pAction: TAction): TPdvFrame;

function VendaPagListCreate: IVendaPagList;

function VendaPagCreate(AOrdem: SmallInt; APagamentoFormaId: TId;
  APagamentoFormaTipoId: string; APagamentoFormaTipoDescrRed: string;
  APagamentoFormaDescr: string; AValorDevido, AValorEntregue, ATroco: Currency;
  ACancelado: Boolean): IVendaPag;

function GavetaNaoTemCreate: IGaveta;
function GavetaWinCreate(pTerminal: ITerminal): IGaveta;
function GavetaCreate(pTerminal: ITerminal): IGaveta;

function BalancaVendaFormCreate(pTerminal: ITerminal): TBalancaVendaForm;
function BalancaCreate(pBalancaVendaForm: TBalancaVendaForm = nil): IBalanca;

// function CupomEspelhoCreate(pAppObj: IAppObj; pTipoCupom: string): ICupomEspelho;
function CupomEspelhoVendaCreate(pAppObj: IAppObj): ICupomEspelho;
function ImpressaoTextoVendaCreate(pImpressoraNome: string; pUsuario: IUsuario;
  pAppObj: IAppObj; pTerminal: ITerminal; pPDVVenda: IPDVVenda): IImpressao;

function CupomEspelhoCxOperacaoCreate(pAppObj: IAppObj): ICupomEspelho;
function ImpressaoTextoCxOperacaoCreate(pImpressoraNome: string;
  pUsuario: IUsuario; pAppObj: IAppObj; pTerminal: ITerminal;
  pCxOperacaoEnt: ICxOperacaoEnt): IImpressao;

implementation

uses System.SysUtils, App.PDV.VendaPag.List_u, Sis.UI.IO.Files

    , App.UI.PDV.Aviso.Frame_u //
    , App.PDV.VendaPag_u //

    , App.PDV.UI.Gaveta.NaoTem_u //
    , App.PDV.UI.Gaveta.Win_u //

    , App.PDV.UI.Balanca_u //

    , App.PDV.CupomEspelho_u //

    , App.PDV.UI.Balanca.VendaForm.Teste_u //
    , App.PDV.UI.Balanca.VendaForm.Acbr_u, System.IniFiles //

    , App.PDV.ImpressaoTextoCxOperacao_u //
    ;

function PDVFrameAvisoCreate(pParent: TWinControl; pPDVObj: IPDVObj;
  pCaption: TCaption; pAction: TAction): TPdvFrame;
begin
  Result := TAvisoPDVFrame.Create(pParent, pPDVObj, pCaption, pAction);
end;

function VendaPagListCreate: IVendaPagList;
begin
  Result := TVendaPagList.Create;
end;

function VendaPagCreate(AOrdem: SmallInt; APagamentoFormaId: TId;
  APagamentoFormaTipoId: string; APagamentoFormaTipoDescrRed: string;
  APagamentoFormaDescr: string; AValorDevido, AValorEntregue, ATroco: Currency;
  ACancelado: Boolean): IVendaPag;
begin
  Result := TVendaPag.Create(AOrdem, APagamentoFormaId, APagamentoFormaTipoId,
    APagamentoFormaTipoDescrRed, APagamentoFormaDescr, AValorDevido,
    AValorEntregue, ATroco, ACancelado);
end;

function GavetaNaoTemCreate: IGaveta;
begin
  Result := TGavetaNaoTem.Create;
end;

function GavetaWinCreate(pTerminal: ITerminal): IGaveta;
begin
  Result := TGavetaWin.Create(pTerminal);
end;

function GavetaCreate(pTerminal: ITerminal): IGaveta;
begin
  if pTerminal.GavetaTem then
  begin
    Result := GavetaWinCreate(pTerminal)
  end
  else
  begin
    Result := GavetaNaoTemCreate;
  end;
end;

function CupomEspelhoCreate(pAppObj: IAppObj; pTipoCupom: string)
  : ICupomEspelho;
begin
  Result := TCupomEspelho.Create(pAppObj, pTipoCupom);
end;

function CupomEspelhoVendaCreate(pAppObj: IAppObj): ICupomEspelho;
begin
  Result := TCupomEspelho.Create(pAppObj, 'Venda');
end;

function ImpressaoTextoVendaCreate(pImpressoraNome: string; pUsuario: IUsuario;
  pAppObj: IAppObj; pTerminal: ITerminal; pPDVVenda: IPDVVenda): IImpressao;
begin
  Result := TImpressaoTextoPDVVenda.Create(pImpressoraNome, pUsuario, pAppObj,
    pTerminal, pPDVVenda);
end;

function BalancaVendaFormCreate(pTerminal: ITerminal): TBalancaVendaForm;
var
  sNomeArqIni: string;
  bBalTeste: Boolean;
  IniFile: TIniFile;
begin
  if pTerminal.BalancaId = 0 then
  begin
    Result := nil;
    exit;
  end;

  sNomeArqIni := GetPastaDoArquivo(Paramstr(0));
  sNomeArqIni := PastaAcima(sNomeArqIni);
  sNomeArqIni := sNomeArqIni + 'Configs\' + 'bal.ini';

  if FileExists(sNomeArqIni) then
  begin
    IniFile := TIniFile.Create(sNomeArqIni);
    try
      bBalTeste := IniFile.ReadBool('bal', 'balanca_teste', False);
    finally
      IniFile.Free;
    end;
  end
  else
  begin
    bBalTeste := False;
  end;

  if bBalTeste then
    Result := TBalancaTesteVendaForm.Create(nil)
  else
    Result := TBalancaAcbrVendaForm.Create(nil, pTerminal);
end;

function BalancaCreate(pBalancaVendaForm: TBalancaVendaForm): IBalanca;
begin
  Result := TBalanca.Create(pBalancaVendaForm);
end;

function CupomEspelhoCxOperacaoCreate(pAppObj: IAppObj): ICupomEspelho;
begin
  Result := TCupomEspelho.Create(pAppObj, 'Operacao de Caixa');
end;

function ImpressaoTextoCxOperacaoCreate(pImpressoraNome: string;
  pUsuario: IUsuario; pAppObj: IAppObj; pTerminal: ITerminal;
  pCxOperacaoEnt: ICxOperacaoEnt): IImpressao;
begin
  Result := TImpressaoTextoPDVCxOperacao.Create(pImpressoraNome, pUsuario,
    pAppObj, pTerminal, pCxOperacaoEnt);
end;

end.
