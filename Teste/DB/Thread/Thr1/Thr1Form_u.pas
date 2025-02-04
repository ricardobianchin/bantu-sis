unit Thr1Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, Data.DB, ProdCopiarThread_u, Vcl.StdCtrls,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, Vcl.ExtCtrls;

type
  TThr1Form = class(TForm)
    StatusLabel1: TLabel;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    Timer1: TTimer;
    StatusLabel2: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    CopyThread1: TProdCopiarThread;
    CopyThread2: TProdCopiarThread;
    FPrecisaFechar: Boolean;

    procedure Execute;
    procedure ThreadTerminated(Sender: TObject);
    procedure ThreadTerminated2(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Thr1Form: TThr1Form;

implementation

{$R *.dfm}

procedure TThr1Form.Button1Click(Sender: TObject);
begin
  FPrecisaFechar := True;
end;

procedure TThr1Form.Execute;
begin
  if FPrecisaFechar then
  begin
    if (not Assigned(CopyThread1)) and (not Assigned(CopyThread2)) then
      close;
    exit;
  end;

  if not Assigned(CopyThread1) then
  begin
    StatusLabel1.Caption := 'Iniciou';
    CopyThread1 := TProdCopiarThread.Create(1);
    CopyThread1.OnTerminate := ThreadTerminated;
    CopyThread1.Resume;
  end;

  if not Assigned(CopyThread2) then
  begin
    StatusLabel2.Caption := 'Iniciou';
    CopyThread2 := TProdCopiarThread.Create(2);
    CopyThread2.OnTerminate := ThreadTerminated2;
    CopyThread2.Resume;
  end;
end;

procedure TThr1Form.FormCreate(Sender: TObject);
//var
//  b: boolean;
begin
  FPrecisaFechar := False;
(*
  b := FDManager.SilentMode;
  b := FDManager.Active;
  b := FDManager.ResourceOptions.SilentMode;
  b := FDManager.ResourceOptions.AutoReconnect;

  FDManager.SilentMode := True;
  FDManager.Active := True;
  FDManager.ResourceOptions.SilentMode := True;
  FDManager.ResourceOptions.AutoReconnect := True;
*)
end;

procedure TThr1Form.ThreadTerminated(Sender: TObject);
begin
  StatusLabel1.Caption := 'Terminou';
  CopyThread1 := nil;
end;

procedure TThr1Form.ThreadTerminated2(Sender: TObject);
begin
  StatusLabel2.Caption := 'Terminou';
  CopyThread2 := nil;
end;

procedure TThr1Form.Timer1Timer(Sender: TObject);
begin
  Execute;
end;

end.
