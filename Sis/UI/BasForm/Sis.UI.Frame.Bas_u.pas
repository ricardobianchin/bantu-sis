unit Sis.UI.Frame.Bas_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TBasFrame = class(TFrame)
  private
    { Private declarations }
  protected
    procedure EditKeyDown(Sender:TObject; var Key:word; Shift: TShiftState); virtual;
    procedure EditKeyPress(Sender: TObject; var Key: Char; pCharExceto:string=''); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }

  end;

implementation

{$R *.dfm}

uses Sis.Types.strings_u;

{ TBasFrame }

constructor TBasFrame.Create(AOwner: TComponent);
begin
  inherited;
  if AOwner is TWinControl then
    Parent := TWinControl(AOwner);
  ShowHint := True;
end;

procedure TBasFrame.EditKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin

end;

procedure TBasFrame.EditKeyPress(Sender: TObject; var Key: Char;
  pCharExceto: string);
begin
  CharSemAcento(Key);
end;

end.
