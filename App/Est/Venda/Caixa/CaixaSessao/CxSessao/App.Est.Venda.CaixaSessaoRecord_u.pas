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
    procedure Zerar;
  end;

implementation


{ TCaixaSessaoRec }

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
