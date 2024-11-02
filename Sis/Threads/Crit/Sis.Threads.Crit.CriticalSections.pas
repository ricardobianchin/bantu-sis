unit Sis.Threads.Crit.CriticalSections;

interface

uses Sis.Threads.Crit.FixedCriticalSection_u;

type
  ICriticalSections = interface
    ['{B23E7656-7000-4BE7-9848-F530C2609FC2}']
    function GetDB: TFixedCriticalSection;
    property DB: TFixedCriticalSection read GetDB;

    function GetNF: TFixedCriticalSection;
    property NF: TFixedCriticalSection read GetNF;

    function GetFiles: TFixedCriticalSection;
    property Files: TFixedCriticalSection read GetFiles;
  end;

implementation

end.
