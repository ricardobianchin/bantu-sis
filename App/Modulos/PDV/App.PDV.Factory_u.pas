unit App.PDV.Factory_u;

interface

uses Sis.Entities.Types, System.Classes, Sis.Types, App.PDV.UI.Gaveta,
  App.UI.PDV.Frame_u, Vcl.ComCtrls, Vcl.Controls, Vcl.ActnList, Vcl.Forms,
  App.PDV.VendaPag.List, App.PDV.VendaPag, Sis.Terminal, App.PDV.Obj,
  App.PDV.CupomEspelho, App.AppObj, Sis.UI.Impressao, App.PDV.Venda,
  App.PDV.UI.Balanca, Sis.Usuario,
  App.PDV.UI.Balanca.VendaForm_u, App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent,
  App.Est.Venda.CaixaSessaoRecord_u, App.Est.Venda.CaixaSessao.DBI,
  App.Est.Venda.Caixa.CaixaSessao, Sis.DB.DBTypes, App.PDV.Controlador,
  System.SysUtils;

function PDVFrameAvisoCreate(pParent: TWinControl; pAppObj: IAppObj;
  pPDVObj: IPDVObj; pCaption: TCaption; pAction: TAction): TPdvFrame;

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

function ImpressaoMudoCreate: IImpressao;

// function CupomEspelhoCreate(pAppObj: IAppObj; pTipoCupom: string): ICupomEspelho;
function CupomEspelhoVendaCreate(pAppObj: IAppObj): ICupomEspelho;
function ImpressaoTextoVendaCreate(pImpressoraNome: string; pUsuarioId: integer;
  pUsuarioNomeExib: string; pAppObj: IAppObj; pTerminal: ITerminal;
  pPDVVenda: IPDVVenda): IImpressao;

function CupomEspelhoCxOperacaoCreate(pAppObj: IAppObj): ICupomEspelho;
function ImpressaoTextoCxOperacaoCreate(pImpressoraNome: string;
  pUsuarioId: integer; pUsuarioNomeExib: string; pAppObj: IAppObj;
  pTerminal: ITerminal; pCxOperacaoEnt: ICxOperacaoEnt): IImpressao;

function CupomEspelhoCxSessRelatCreate(pAppObj: IAppObj): ICupomEspelho;
function ImpressaoTextoCxSessRelatCreate(pImpressoraNome: string;
  pUsuarioId: integer; pUsuarioNomeExib: string; pAppObj: IAppObj;
  pTerminal: ITerminal; pCaixaSessaoDBI: ICaixaSessaoDBI;
  pCaixaSessao: ICaixaSessao): IImpressao;

function PDVControladorCreate: IPDVControlador;

implementation

uses App.PDV.VendaPag.List_u, Sis.UI.IO.Files

    , App.UI.PDV.Aviso.Frame_u //
    , App.PDV.VendaPag_u //

    , App.PDV.UI.Gaveta.NaoTem_u //
    , App.PDV.UI.Gaveta.Win_u //

    , App.PDV.UI.Balanca_u //

    , App.PDV.CupomEspelho_u //

    , App.PDV.UI.Balanca.VendaForm.Teste_u //
    , App.PDV.UI.Balanca.VendaForm.Acbr_u, System.IniFiles //

    , Sis.UI.Impressao.Types_u //
    , Sis.UI.ImpressaoMudo_u //

    , App.PDV.ImpressaoTextoCxOperacao_u //
    , App.PDV.ImpressaoTextoCxSessRelat_u //
    , App.PDV.ImpressaoTextoVenda_u //

    , App.PDV.ImpressaoTextoPOSPrinterCxOperacao_u //
    , App.PDV.ImpressaoTextoPOSPrinterCxSessRelat_u //
    , App.PDV.ImpressaoTextoPOSPrinterVenda_u //

    , App.PDV.Controlador_u //
    ;

function PDVFrameAvisoCreate(pParent: TWinControl; pAppObj: IAppObj;
  pPDVObj: IPDVObj; pCaption: TCaption; pAction: TAction): TPdvFrame;
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

function ImpressaoMudoCreate: IImpressao;
begin
  Result := TImpressaoMudo.Create;
end;

function ImpressaoTextoVendaCreate(pImpressoraNome: string; pUsuarioId: integer;
  pUsuarioNomeExib: string; pAppObj: IAppObj; pTerminal: ITerminal;
  pPDVVenda: IPDVVenda): IImpressao;
var
  rMod: TImpressoraModelo;
  rEnv: TImpressoraModoEnvio;
begin
  rMod := TImpressoraModelo(pTerminal.ImpressoraModeloId);
  rEnv := TImpressoraModoEnvio(pTerminal.ImpressoraModoEnvioId);

  case rMod of
    imprmodelTexto:
      begin
        case rEnv of
          imprenvSem:
            Result := ImpressaoMudoCreate;
          imprenvPOSPrinter:
            Result := TImpressaoTextoPOSPrinterPDVVenda.Create(pImpressoraNome,
              pUsuarioId, pUsuarioNomeExib, pAppObj, pTerminal, pPDVVenda);
          imprenvWinSpool:
            Result := TImpressaoTextoPDVVenda.Create(pImpressoraNome,
              pUsuarioId, pUsuarioNomeExib, pAppObj, pTerminal, pPDVVenda);
        end;
      end;
  end;
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
  pUsuarioId: integer; pUsuarioNomeExib: string; pAppObj: IAppObj;
  pTerminal: ITerminal; pCxOperacaoEnt: ICxOperacaoEnt): IImpressao;
var
  rMod: TImpressoraModelo;
  rEnv: TImpressoraModoEnvio;
begin
  rMod := TImpressoraModelo(pTerminal.ImpressoraModeloId);
  rEnv := TImpressoraModoEnvio(pTerminal.ImpressoraModoEnvioId);

  case rMod of
    imprmodelTexto:
      begin
        case rEnv of
          imprenvSem:
            Result := ImpressaoMudoCreate;
          imprenvPOSPrinter:
            Result := TImpressaoTextoPOSPrinterPDVCxOperacao.Create
              (pImpressoraNome, pUsuarioId, pUsuarioNomeExib, pAppObj,
              pTerminal, pCxOperacaoEnt);
          imprenvWinSpool:
            Result := TImpressaoTextoPDVCxOperacao.Create(pImpressoraNome,
              pUsuarioId, pUsuarioNomeExib, pAppObj, pTerminal, pCxOperacaoEnt);
        end;
      end;
  end;
end;

function CupomEspelhoCxSessRelatCreate(pAppObj: IAppObj): ICupomEspelho;
begin
  Result := TCupomEspelho.Create(pAppObj, 'Relatorio de Caixa');
end;

function ImpressaoTextoCxSessRelatCreate(pImpressoraNome: string;
  pUsuarioId: integer; pUsuarioNomeExib: string; pAppObj: IAppObj;
  pTerminal: ITerminal; pCaixaSessaoDBI: ICaixaSessaoDBI;
  pCaixaSessao: ICaixaSessao): IImpressao;
var
  rMod: TImpressoraModelo;
  rEnv: TImpressoraModoEnvio;
begin
  rMod := TImpressoraModelo(pTerminal.ImpressoraModeloId);
  rEnv := TImpressoraModoEnvio(pTerminal.ImpressoraModoEnvioId);

  case rMod of
    imprmodelTexto:
      begin
        case rEnv of
          imprenvSem:
            Result := ImpressaoMudoCreate;
          imprenvPOSPrinter:
            Result := TImpressaoTextoPOSPrinterPDVCxSessRelat.Create
              (pImpressoraNome, pUsuarioId, pUsuarioNomeExib, pAppObj,
              pTerminal, pCaixaSessaoDBI, pCaixaSessao);
          imprenvWinSpool:
            Result := TImpressaoTextoPDVCxSessRelat.Create(pImpressoraNome,
              pUsuarioId, pUsuarioNomeExib, pAppObj, pTerminal, pCaixaSessaoDBI,
              pCaixaSessao);
        end;
      end;
  end;
end;

function PDVControladorCreate: IPDVControlador;
begin
  Result := TPDVControlador.Create;
end;

end.
