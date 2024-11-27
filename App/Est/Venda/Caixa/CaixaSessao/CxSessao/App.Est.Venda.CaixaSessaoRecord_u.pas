unit App.Est.Venda.CaixaSessaoRecord_u;

interface

uses Sis.Entities.Types;

type
  TCaixaSessaoRec = record
    LojaId: TLojaId;
    TerminalId: TTerminalId;
    SessId: integer;
    LogId: Int64;
    PessoaId: integer;
    Apelido: string;
    RegistrouFundoDeTroco: Boolean;
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
  LogId := 0;
  PessoaId := 0;
  Apelido := '';
  RegistrouFundoDeTroco := False;
  Conferido := False;
  Aberto := False;
end;

end.
