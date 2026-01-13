object dmSistemaSorteio: TdmSistemaSorteio
  OnCreate = DataModuleCreate
  Height = 262
  Width = 391
  object FDManager: TFDManager
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 40
    Top = 144
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 41
    Top = 72
  end
  object FDConexao: TFDConnection
    Params.Strings = (
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB'
      'Port=3050')
    LoginPrompt = False
    Left = 40
    Top = 8
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 136
    Top = 8
  end
  object qrAuxiliar: TFDQuery
    Connection = FDConexao
    Left = 287
    Top = 174
  end
end
