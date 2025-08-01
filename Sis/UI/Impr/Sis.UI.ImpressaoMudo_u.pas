unit Sis.UI.ImpressaoMudo_u;

interface

uses Sis.UI.Impressao_u, Sis.Usuario;

type
  TImpressaoMudo = class(TImpressao)
  private

  protected

    function GetDocTitulo: string; override;
    function GetAtivo: Boolean; override;

  public
    procedure Imprima; virtual;
    constructor Create();
  end;

implementation

uses Sis.Sis.Constants;

{ TImpressaoMudo }

constructor TImpressaoMudo.Create();
begin
  inherited Create('', 0, '');
end;

function TImpressaoMudo.GetAtivo: Boolean;
begin
  Result :=  False;
end;

function TImpressaoMudo.GetDocTitulo: string;
begin
  Result :=  '';
end;

procedure TImpressaoMudo.Imprima;
begin
end;

end.
