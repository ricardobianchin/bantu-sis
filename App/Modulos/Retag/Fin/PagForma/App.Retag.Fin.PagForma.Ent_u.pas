unit App.Retag.Fin.PagForma.Ent_u;

interface

uses App.Ent.Ed.Id.Descr, App.FIn.PagFormaTipo, App.Ent.Ed.Id.Descr_u, App.Retag.Fin.PagForma.Ent,
  Sis.Types.Bool_u;

type
  TPagFormaEnt = class(TEntIdDescr, IPagFormaEnt)
  private
    FPagFormaTipo: IPagFormaTipo;
    FDescrRed: string;
    FParaVenda: boolean;
    FAtivo: boolean;
    FSis: boolean;
    FPromocaoPermite: boolean;
    FComicaoPermite: boolean;
    FTaxaAdmPerc: Currency;
    FVendaMinima: Currency;
    FComissaoAbaterPerc: Currency;
    FReembolsoDias: smallint;
    FTEFUsa: boolean;
    FAutorizacaoExige: boolean;
    FPessoaExige: boolean;
    FAVista: boolean;

    FLojaId: smallint;
    FUsuarioId: integer;
    FMachineIdentId: smallint;


    function GetPagFormaTipo: IPagFormaTipo;

    function GetDescrRed: string;
    procedure SetDescrRed(Value: string);

    function GetParaVenda: boolean;
    procedure SetParaVenda(Value: boolean);
    property ParaVenda: boolean read GetParaVenda write SetParaVenda;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);

    function GetSis: boolean;
    procedure SetSis(Value: boolean);

    function GetPromocaoPermite: boolean;
    procedure SetPromocaoPermite(Value: boolean);

    function GetComicaoPermite: boolean;
    procedure SetComicaoPermite(Value: boolean);

    function GetTaxaAdmPerc: Currency;
    procedure SetTaxaAdmPerc(Value: Currency);

    function GetVendaMinima: Currency;
    procedure SetVendaMinima(Value: Currency);

    function GetComissaoAbaterPerc: Currency;
    procedure SetComissaoAbaterPerc(Value: Currency);

    function GetReembolsoDias: smallint;
    procedure SetReembolsoDias(Value: smallint);

    function GetTEFUsa: boolean;
    procedure SetTEFUsa(Value: boolean);

    function GetAutorizacaoExige: boolean;
    procedure SetAutorizacaoExige(Value: boolean);

    function GetPessoaExige: boolean;
    procedure SetPessoaExige(Value: boolean);

    function GetAVista: boolean;
    procedure SetAVista(Value: boolean);

    function GetLojaId: smallint;
    function GetUsuarioId: integer;
    function GetMachineIdentId: smallint;

    function GetFormaTipo: char;
    procedure SetFormaTipo(Value: char);
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;

    function GetDescrCaption: string; override;
    function GetStrDescreve: string; override;


  public
    property PagFormaTipo: IPagFormaTipo read GetPagFormaTipo;

    property DescrRed: string read GetDescrRed write SetDescrRed;

    property Ativo: boolean read GetAtivo write SetAtivo;
    property Sis: boolean read GetSis write SetSis;

    property PromocaoPermite: boolean read GetPromocaoPermite write SetPromocaoPermite;
    property ComicaoPermite: boolean read GetComicaoPermite write SetComicaoPermite;

    property TaxaAdmPerc: Currency read GetTaxaAdmPerc write SetTaxaAdmPerc;
    property VendaMinima: Currency read GetVendaMinima write SetVendaMinima;
    property ComissaoAbaterPerc: Currency read GetComissaoAbaterPerc write SetComissaoAbaterPerc;
    property ReembolsoDias: smallint read GetReembolsoDias write SetReembolsoDias;

    property TEFUsa: boolean read GetTEFUsa write SetTEFUsa;
    property AutorizacaoExige: boolean read GetAutorizacaoExige write SetAutorizacaoExige;
    property PessoaExige: boolean read GetPessoaExige write SetPessoaExige;
    property AVista: boolean read GetAVista write SetAVista;

    property LojaId: smallint read GetLojaId;
    property UsuarioId: integer read GetUsuarioId;
    property MachineIdentId: smallint read GetMachineIdentId;

    procedure LimparEnt; override;

    function GetUsoStr: string;
    property FormaTipo: char read GetFormaTipo write SetFormaTipo;

    constructor Create(pLojaId: smallint; pUsuarioId: integer;
      pMachineIdentId: smallint; pPagFormaTipo: IPagFormaTipo);
  end;

implementation

uses Data.DB;

{ TPagFormaEnt }

constructor TPagFormaEnt.Create(pLojaId: smallint; pUsuarioId: integer;
  pMachineIdentId: smallint; pPagFormaTipo: IPagFormaTipo);
begin
  inherited Create(dsBrowse);
  FLojaId := pLojaId;
  FUsuarioId := pUsuarioId;
  FMachineIdentId := pMachineIdentId;
  FPagFormaTipo := pPagFormaTipo;
  LimparEnt;
end;

function TPagFormaEnt.GetAtivo: boolean;
begin
  Result := FAtivo;
end;

function TPagFormaEnt.GetAutorizacaoExige: boolean;
begin
  Result := FAutorizacaoExige;
end;

function TPagFormaEnt.GetAVista: boolean;
begin
  Result := FAVista;
end;

function TPagFormaEnt.GetComicaoPermite: boolean;
begin
  Result := FComicaoPermite;
end;

function TPagFormaEnt.GetComissaoAbaterPerc: Currency;
begin
  Result := FComissaoAbaterPerc;
end;

function TPagFormaEnt.GetDescrCaption: string;
begin
  Result := 'Descrição';
end;

function TPagFormaEnt.GetDescrRed: string;
begin
  Result := FDescrRed;
end;

function TPagFormaEnt.GetFormaTipo: char;
var
  I: integer;
  c: char;
begin
  I := FPagFormaTipo.Id;
  c := CHR(I);
  Result := c;
end;

function TPagFormaEnt.GetLojaId: smallint;
begin
  Result := FLojaId;
end;

function TPagFormaEnt.GetMachineIdentId: smallint;
begin
  Result := FMachineIdentId;
end;

function TPagFormaEnt.GetNomeEnt: string;
begin
  Result := 'Forma de Pagamento';
end;

function TPagFormaEnt.GetNomeEntAbrev: string;
begin
  Result := 'FormaPag';
end;

function TPagFormaEnt.GetPagFormaTipo: IPagFormaTipo;
begin
  Result := FPagFormaTipo;
end;

function TPagFormaEnt.GetParaVenda: boolean;
begin
  Result := FParaVenda;
end;

function TPagFormaEnt.GetPessoaExige: boolean;
begin
  Result := FPessoaExige;
end;

function TPagFormaEnt.GetPromocaoPermite: boolean;
begin
  Result := FPromocaoPermite;
end;

function TPagFormaEnt.GetReembolsoDias: smallint;
begin
  Result := FReembolsoDias;
end;

function TPagFormaEnt.GetSis: boolean;
begin
  Result := FSis;
end;

function TPagFormaEnt.GetStrDescreve: string;
begin
  Result := PagFormaTipo.DescrRed + ' ' + Descr;
  if Descr = '' then
    exit;

  Result := Result + ' ' + GetUsoStr;
end;

function TPagFormaEnt.GetTaxaAdmPerc: Currency;
begin
  Result := FTaxaAdmPerc;
end;

function TPagFormaEnt.GetTEFUsa: boolean;
begin
  Result := FTEFUsa;
end;

function TPagFormaEnt.GetTitulo: string;
begin
  Result := 'Formas de Pagamento';
end;

function TPagFormaEnt.GetUsoStr: string;
begin
  Result := Iif(FParaVenda, 'PARA VENDA', 'PARA COMPRA');
end;

function TPagFormaEnt.GetUsuarioId: integer;
begin
  Result := FUsuarioId;
end;

function TPagFormaEnt.GetVendaMinima: Currency;
begin
  Result := FVendaMinima;
end;

procedure TPagFormaEnt.LimparEnt;
begin
  inherited;
  FPagFormaTipo.Zerar;
  FDescrRed := '';
  FParaVenda := True;
  FAtivo := True;
  FSis := False;
  FPromocaoPermite := True;
  FComicaoPermite := True;
  FTaxaAdmPerc := 0;
  FVendaMinima := 0;
  FComissaoAbaterPerc := 0;
  FReembolsoDias := 0;
  FTEFUsa := False;
  FAutorizacaoExige := False;
  FPessoaExige := False;
  FAVista := False;
end;

procedure TPagFormaEnt.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

procedure TPagFormaEnt.SetAutorizacaoExige(Value: boolean);
begin
  FAutorizacaoExige := Value;
end;

procedure TPagFormaEnt.SetAVista(Value: boolean);
begin
  FAVista := Value;
end;

procedure TPagFormaEnt.SetComicaoPermite(Value: boolean);
begin
  FComicaoPermite := Value;
end;

procedure TPagFormaEnt.SetComissaoAbaterPerc(Value: Currency);
begin
  FComissaoAbaterPerc := Value;
end;

procedure TPagFormaEnt.SetDescrRed(Value: string);
begin
  FDescrRed := Value;
end;

procedure TPagFormaEnt.SetFormaTipo(Value: char);
var
  I: integer;
begin
  I := Ord(Value);
  FPagFormaTipo.Id := I;
end;

procedure TPagFormaEnt.SetParaVenda(Value: boolean);
begin
  FParaVenda := Value;
end;

procedure TPagFormaEnt.SetPessoaExige(Value: boolean);
begin
  FPessoaExige := Value;
end;

procedure TPagFormaEnt.SetPromocaoPermite(Value: boolean);
begin
  FPromocaoPermite := Value;
end;

procedure TPagFormaEnt.SetReembolsoDias(Value: smallint);
begin
  FReembolsoDias := Value;
end;

procedure TPagFormaEnt.SetSis(Value: boolean);
begin
  FSis := Value;
end;

procedure TPagFormaEnt.SetTaxaAdmPerc(Value: Currency);
begin
  FTaxaAdmPerc := Value;
end;

procedure TPagFormaEnt.SetTEFUsa(Value: boolean);
begin
  FTEFUsa := Value;
end;

procedure TPagFormaEnt.SetVendaMinima(Value: Currency);
begin
  FVendaMinima := Value;
end;

end.
