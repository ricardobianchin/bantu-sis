unit ProdCopiarThread_u;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, Data.DB, FireDAC.DApt;

type
  TProdCopiarThread = class(TThread)
  private
    { Private declarations }
    FConnServ, FConnTerm: TFDConnection;
    FQueryServ, FQueryTerm: TFDQuery;
    FTermId: smallint;

    procedure SetupConnection(AConn: TFDConnection; const AServer, ADatabase: string);

  protected
    procedure Execute; override;
  public
    constructor Create(pTermId: smallint);
    destructor Destroy; override;
  end;

implementation

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TProdCopiarThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end;

    or

    Synchronize(
      procedure
      begin
        Form1.Caption := 'Updated in thread via an anonymous method'
      end
      )
    );

  where an anonymous method is passed.

  Similarly, the developer can call the Queue method with similar parameters as
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.

}

{ TProdCopiarThread }

constructor TProdCopiarThread.Create(pTermId: smallint);
begin
  inherited Create(False); // Inicia automaticamente
  FreeOnTerminate := True; // Libera automaticamente após conclusão
  FConnServ := TFDConnection.Create(nil);
  FConnTerm := TFDConnection.Create(nil);
  FTermId := pTermId;
end;

destructor TProdCopiarThread.Destroy;
begin
  FQueryServ.Free;
  FQueryTerm.Free;
  FConnServ.Free;
  FConnTerm.Free;
  inherited;
end;

procedure TProdCopiarThread.Execute;
begin
  try
    SetupConnection(FConnServ, 'DELPHI-BTU', 'C:\Pr\app\bantu\bantu-sis\Src\Teste\DB\Thread\Thr1\Serv.fdb');
    SetupConnection(FConnTerm, 'DELPHI-BTU', 'C:\Pr\app\bantu\bantu-sis\Src\Teste\DB\Thread\Thr1\Term'+FTermId.ToString+'.fdb');

    FQueryServ := TFDQuery.Create(nil);
    FQueryServ.Connection := FConnServ;
    FQueryServ.SQL.Text := 'SELECT prod_id, prod_nome FROM prod order by prod_id';
    FQueryServ.Open;

    FConnTerm.StartTransaction;
    FConnTerm.ExecSQL('delete from prod;');

    FQueryTerm := TFDQuery.Create(nil);
    FQueryTerm.Connection := FConnTerm;
    FQueryTerm.SQL.Text := 'insert into prod(prod_id, prod_nome) values(:p1, :p2);';
    FQueryTerm.Prepared := True;

    while not FQueryServ.Eof do
    begin
      FQueryTerm.Params[0].Value := FQueryServ.Fields[0].Value;
      FQueryTerm.Params[1].Value := FQueryServ.Fields[1].Value;
      FQueryTerm.ExecSQL;
      sleep(100+random(500));
      FQueryServ.Next;
    end;
    FConnTerm.Commit;
    FQueryTerm.Prepared := False;

  except
    on E: Exception do
      TThread.Queue(nil, procedure
      begin
        // Log ou tratativa de erro aqui
      end);
  end;
end;

procedure TProdCopiarThread.SetupConnection(AConn: TFDConnection;
  const AServer, ADatabase: string);
begin
  AConn.Params.Clear;
  AConn.Params.Add('Database=' + ADatabase);
  AConn.Params.Add('User_Name=sysdba');
  AConn.Params.Add('Password=masterkey');
  AConn.Params.Add('Server='+AServer);
  AConn.Params.Add('Port=3050');
  AConn.Params.Add('Protocol=TCPIP');
//  AConn.Params.Add('CharacterSet=UTF8');
  AConn.Params.Add('OpenMode=ReadWrite');
  AConn.DriverName := 'FB';
  AConn.ResourceOptions.SilentMode := True;
  AConn.LoginPrompt := False;
  AConn.Connected := True;
end;

end.
