unit btu.lib.db.updater.campo.list;

interface

uses System.Classes, btu.lib.db.updater.campo;

type
  ICampoList = interface(IInterfaceList)
    ['{6E6D61AD-7C81-4025-B848-889994E10743}']
    function GetPKFieldNames: string;
    property PKFieldNames: string read GetPKFieldNames;

    function GetCampo(Index: integer): ICampo;
    property Campo[Index: integer]: ICampo read GetCampo; default;

    function GetAsCreateTableFields: string;
    property AsCreateTableFields: string read GetAsCreateTableFields;
  end;

implementation

end.
