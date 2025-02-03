enum StateEnum {
  todos,
  ac,
  al,
  ap,
  am,
  ba,
  ce,
  df,
  es,
  go,
  ma,
  mt,
  ms,
  mg,
  pa,
  pb,
  pr,
  pe,
  pi,
  rj,
  rn,
  rs,
  ro,
  rr,
  sc,
  sp,
  se,
  to,
}

extension StateEnumExtension on StateEnum {
  String get label {
    switch (this) {
      case StateEnum.todos:
        return 'Todos';
      case StateEnum.ac:
        return 'AC';
      case StateEnum.al:
        return 'AL';
      case StateEnum.ap:
        return 'AP';
      case StateEnum.am:
        return 'AM';
      case StateEnum.ba:
        return 'BA';
      case StateEnum.ce:
        return 'CE';
      case StateEnum.df:
        return 'DF';
      case StateEnum.es:
        return 'ES';
      case StateEnum.go:
        return 'GO';
      case StateEnum.ma:
        return 'MA';
      case StateEnum.mt:
        return 'MT';
      case StateEnum.ms:
        return 'MS';
      case StateEnum.mg:
        return 'MG';
      case StateEnum.pa:
        return 'PA';
      case StateEnum.pb:
        return 'PB';
      case StateEnum.pr:
        return 'PR';
      case StateEnum.pe:
        return 'PE';
      case StateEnum.pi:
        return 'PI';
      case StateEnum.rj:
        return 'RJ';
      case StateEnum.rn:
        return 'RN';
      case StateEnum.rs:
        return 'RS';
      case StateEnum.ro:
        return 'RO';
      case StateEnum.rr:
        return 'RR';
      case StateEnum.sc:
        return 'SC';
      case StateEnum.sp:
        return 'SP';
      case StateEnum.se:
        return 'SE';
      case StateEnum.to:
        return 'TO';
    }
  }
}