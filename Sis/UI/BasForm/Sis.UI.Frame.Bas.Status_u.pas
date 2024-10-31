unit Sis.UI.Frame.Bas.Status_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.StdCtrls;

type
  TStatusFrame = class(TBasFrame)
    TitLabel: TLabel;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PrevineFechamento; virtual;
    function PodeFechar: boolean; virtual;
  end;

//var
//  StatusFrame: TStatusFrame;

implementation

{$R *.dfm}

{ TStatusFrame }

function TStatusFrame.PodeFechar: boolean;
begin
  Result := True;
end;

procedure TStatusFrame.PrevineFechamento;
begin

end;

end.
