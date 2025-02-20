unit Sis.UI.Impressao_u;

interface

uses Sis.UI.Impressao, Sis.Usuario;

type
  TImpressao = class(TInterfacedObject, IImpressao)
  private
    FImpressoraNome: string;
    FUsuario: IUsuario;

  protected
    property ImpressoraNome: string read FImpressoraNome;
    property Usuario: IUsuario read FUsuario;

    procedure GereInicio; virtual;
    procedure GereCabec; virtual;
    procedure GereTexto; virtual;
    procedure GereRodape; virtual;
    procedure GereFim; virtual;
    procedure EnvieImpressao; virtual;
    function GetDtDoc: TDateTime; virtual; abstract;
    function GetDocTitulo: string; virtual; abstract;

  public
    procedure Imprima; virtual;
    constructor Create(pImpressoraNome: string; pUsuario: IUsuario);
  end;

implementation

{ TImpressao }

constructor TImpressao.Create(pImpressoraNome: string; pUsuario: IUsuario);
begin
  FImpressoraNome := pImpressoraNome;
  FUsuario := pUsuario;
end;

procedure TImpressao.EnvieImpressao;
begin

end;

procedure TImpressao.GereCabec;
begin

end;

procedure TImpressao.GereFim;
begin

end;

procedure TImpressao.GereInicio;
begin

end;

procedure TImpressao.GereRodape;
begin

end;

procedure TImpressao.GereTexto;
begin

end;

procedure TImpressao.Imprima;
begin
  GereInicio;
  GereTexto;
  GereFim;
  EnvieImpressao;
end;

end.
