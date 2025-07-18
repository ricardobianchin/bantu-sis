unit App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent_u;

interface

uses Sis.Types.Utils_u, App.Ent.Ed_u, Sis.Entities.Types, Data.DB,
  App.Est.Venda.Caixa.CaixaSessao, App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent, App.Est.Venda.Caixa.CxValor,
  App.Est.Venda.Caixa.CxValorList, System.Generics.Collections, App.Types,
  Sis.Types, System.Classes;

type
  TCxOperacaoEnt = class(TEntEd, ICxOperacaoEnt)
  private
    FCaixaSessao: ICaixaSessao;
    FOperOrdem: SmallInt;
    FCxOperacaoTipo: ICxOperacaoTipo;
    FLogId: Int64;
    FOperTipoOrdem: SmallInt;
    FValor: Currency;
    FObs: string;
    FCancelado: Boolean;
    FCxValorList: ICxValorList;
    FCriadoEm: TDateTIme;
    FLinhas: TStrings;

    function GetCaixaSessao: ICaixaSessao;
    function GetOperOrdem: SmallInt;
    procedure SetOperOrdem(Value: SmallInt);
    function GetCxOperacaoTipo: ICxOperacaoTipo;

    function GetLogId: Int64;
    procedure SetLogId(Value: Int64);

    function GetOperTipoOrdem: SmallInt;
    procedure SetOperTipoOrdem(Value: SmallInt);

    function GetValor: Currency;
    procedure SetValor(Value: Currency);

    function GetObs: string;
    procedure SetObs(Value: string);

    function GetCancelado: Boolean;
    procedure SetCancelado(Value: Boolean);

    function GetCxValorList: ICxValorList;

    function GetCriadoEm: TDateTIme;
    procedure SetCriadoEm(Value: TDateTIme);

    function GetLinhas: TStrings;
  protected
    procedure LimparEnt;
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;

  public
    property CaixaSessao: ICaixaSessao read GetCaixaSessao;
    property OperOrdem: SmallInt read GetOperOrdem write SetOperOrdem;
    property CxOperacaoTipo: ICxOperacaoTipo read GetCxOperacaoTipo;
    property OperTipoOrdem: SmallInt read GetOperTipoOrdem
      write SetOperTipoOrdem;
    property Valor: Currency read GetValor write SetValor;
    property Obs: string read GetObs write SetObs;
    property Cancelado: Boolean read GetCancelado write SetCancelado;

    property CriadoEm: TDateTIme read GetCriadoEm write SetCriadoEm;

    property CxValorList: ICxValorList read GetCxValorList;

    function GetCod(pComPrefixo: Boolean = True; pSeparador: string = '-'): string;

    property Linhas: TStrings read GetLinhas;

    constructor Create(pCaixaSessao: ICaixaSessao;
      pCxOperacaoTipo: ICxOperacaoTipo);
    destructor Destroy; override;
  end;

implementation

uses App.Est.Venda.CaixaSessao.Factory_u, System.SysUtils;

{ TCxOperacaoEnt }

constructor TCxOperacaoEnt.Create(pCaixaSessao: ICaixaSessao;
  pCxOperacaoTipo: ICxOperacaoTipo);
begin
  inherited Create(TDataSetState.dsBrowse);
  FCaixaSessao := pCaixaSessao;
  FCxOperacaoTipo := pCxOperacaoTipo;
  FCxValorList := CxValorListCreate;
  FLinhas := TStringList.Create;
end;

destructor TCxOperacaoEnt.Destroy;
begin
  FLinhas.Free;
  inherited;
end;

function TCxOperacaoEnt.GetCaixaSessao: ICaixaSessao;
begin
  Result := FCaixaSessao;
end;

function TCxOperacaoEnt.GetCancelado: Boolean;
begin
  Result := FCancelado;
end;

function TCxOperacaoEnt.GetCxOperacaoTipo: ICxOperacaoTipo;
begin
  Result := FCxOperacaoTipo;
end;

function TCxOperacaoEnt.GetCxValorList: ICxValorList;
begin
  Result := FCxValorList;
end;

function TCxOperacaoEnt.GetLinhas: TStrings;
begin
  Result := FLinhas;
end;

function TCxOperacaoEnt.GetLogId: Int64;
begin
  Result := FLogId;
end;

function TCxOperacaoEnt.GetNomeEnt: string;
begin
  Result := 'Opera��o de Caixa - ' + FCxOperacaoTipo.Caption;
end;

function TCxOperacaoEnt.GetNomeEntAbrev: string;
begin
  Result := FCxOperacaoTipo.Abrev;
end;

function TCxOperacaoEnt.GetObs: string;
begin
  Result := FObs;
end;

function TCxOperacaoEnt.GetOperOrdem: SmallInt;
begin
  Result := FOperOrdem;
end;

function TCxOperacaoEnt.GetOperTipoOrdem: SmallInt;
begin
  Result := FOperTipoOrdem;
end;

function TCxOperacaoEnt.GetTitulo: string;
begin
  Result := 'Opera�oes de Caixa';
end;

function TCxOperacaoEnt.GetValor: Currency;
begin
  Result := FValor;
end;

function TCxOperacaoEnt.GetCod(pComPrefixo: Boolean; pSeparador: string): string;
begin
  Result := FCaixaSessao.GetCod(pComPrefixo, pSeparador) + pSeparador + FOperOrdem.ToString;
end;

function TCxOperacaoEnt.GetCriadoEm: TDateTIme;
begin
  Result := FCriadoEm;
end;

procedure TCxOperacaoEnt.LimparEnt;
begin
  FOperOrdem := 0;
  FLogId := 0;
  FOperTipoOrdem := 0;
  FValor := ZERO_CURRENCY;
  FObs := '';
  FCancelado := False;
end;

procedure TCxOperacaoEnt.SetCancelado(Value: Boolean);
begin
  FCancelado := Value;
end;

procedure TCxOperacaoEnt.SetCriadoEm(Value: TDateTIme);
begin
  FCriadoEm := Value;
end;

procedure TCxOperacaoEnt.SetLogId(Value: Int64);
begin
  FLogId := Value;
end;

procedure TCxOperacaoEnt.SetObs(Value: string);
begin
  FObs := Value;
end;

procedure TCxOperacaoEnt.SetOperOrdem(Value: SmallInt);
begin
  FOperOrdem := Value;
end;

procedure TCxOperacaoEnt.SetOperTipoOrdem(Value: SmallInt);
begin
  FOperTipoOrdem := Value;
end;

procedure TCxOperacaoEnt.SetValor(Value: Currency);
begin
  FValor := Value;
end;

end.
