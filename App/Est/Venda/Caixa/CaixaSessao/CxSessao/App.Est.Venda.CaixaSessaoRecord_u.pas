unit App.Est.Venda.CaixaSessaoRecord_u;

interface

uses Sis.Entities.Types;

type
  TCaixaSessaoRec = record
    LojaId: TLojaId;
    TerminalId: TTerminalId;
    SessId: integer;
    PessoaId: integer;
    Apelido: string;
    Conferido: Boolean;
    Aberto: Boolean;
    AbertoEm: TDateTime;
    procedure Zerar;
    function GetCod(pSeparador: string = '-'): string;
  end;

implementation


{ TCaixaSessaoRec }

function TCaixaSessaoRec.GetCod(pSeparador: string): string;
begin
  Result := Sis.Entities.Types.GetCod(LojaId, TerminalId, SessId, 'CX',
    pSeparador);
end;

procedure TCaixaSessaoRec.Zerar;
begin
  LojaId := 0;
  TerminalId := 0;
  SessId := 0;
  PessoaId := 0;
  Apelido := '';
  Conferido := False;
  Aberto := False;
end;

end.
