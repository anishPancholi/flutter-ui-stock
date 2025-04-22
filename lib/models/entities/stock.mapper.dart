// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'stock.dart';

class StockSearchModelMapper extends ClassMapperBase<StockSearchModel> {
  StockSearchModelMapper._();

  static StockSearchModelMapper? _instance;
  static StockSearchModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StockSearchModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'StockSearchModel';

  static String? _$id(StockSearchModel v) => v.id;
  static const Field<StockSearchModel, String> _f$id =
      Field('id', _$id, opt: true);
  static String? _$tenantId(StockSearchModel v) => v.tenantId;
  static const Field<StockSearchModel, String> _f$tenantId =
      Field('tenantId', _$tenantId, opt: true);
  static String? _$facilityId(StockSearchModel v) => v.facilityId;
  static const Field<StockSearchModel, String> _f$facilityId =
      Field('facilityId', _$facilityId, opt: true);
  static String? _$productVariantId(StockSearchModel v) => v.productVariantId;
  static const Field<StockSearchModel, String> _f$productVariantId =
      Field('productVariantId', _$productVariantId, opt: true);
  static String? _$referenceId(StockSearchModel v) => v.referenceId;
  static const Field<StockSearchModel, String> _f$referenceId =
      Field('referenceId', _$referenceId, opt: true);
  static String? _$referenceIdType(StockSearchModel v) => v.referenceIdType;
  static const Field<StockSearchModel, String> _f$referenceIdType =
      Field('referenceIdType', _$referenceIdType, opt: true);
  static String? _$transactingPartyId(StockSearchModel v) =>
      v.transactingPartyId;
  static const Field<StockSearchModel, String> _f$transactingPartyId =
      Field('transactingPartyId', _$transactingPartyId, opt: true);
  static String? _$transactingPartyType(StockSearchModel v) =>
      v.transactingPartyType;
  static const Field<StockSearchModel, String> _f$transactingPartyType =
      Field('transactingPartyType', _$transactingPartyType, opt: true);
  static String? _$receiverId(StockSearchModel v) => v.receiverId;
  static const Field<StockSearchModel, String> _f$receiverId =
      Field('receiverId', _$receiverId, opt: true);
  static String? _$receiverType(StockSearchModel v) => v.receiverType;
  static const Field<StockSearchModel, String> _f$receiverType =
      Field('receiverType', _$receiverType, opt: true);
  static String? _$senderId(StockSearchModel v) => v.senderId;
  static const Field<StockSearchModel, String> _f$senderId =
      Field('senderId', _$senderId, opt: true);
  static String? _$senderType(StockSearchModel v) => v.senderType;
  static const Field<StockSearchModel, String> _f$senderType =
      Field('senderType', _$senderType, opt: true);
  static List<String>? _$clientReferenceId(StockSearchModel v) =>
      v.clientReferenceId;
  static const Field<StockSearchModel, List<String>> _f$clientReferenceId =
      Field('clientReferenceId', _$clientReferenceId, opt: true);
  static List<String>? _$transactionType(StockSearchModel v) =>
      v.transactionType;
  static const Field<StockSearchModel, List<String>> _f$transactionType =
      Field('transactionType', _$transactionType, opt: true);
  static List<String>? _$transactionReason(StockSearchModel v) =>
      v.transactionReason;
  static const Field<StockSearchModel, List<String>> _f$transactionReason =
      Field('transactionReason', _$transactionReason, opt: true);
  static int? _$dateOfEntry(StockSearchModel v) => v.dateOfEntry;
  static const Field<StockSearchModel, int> _f$dateOfEntry =
      Field('dateOfEntry', _$dateOfEntry, opt: true);
  static DateTime? _$dateOfEntryTime(StockSearchModel v) => v.dateOfEntryTime;
  static const Field<StockSearchModel, DateTime> _f$dateOfEntryTime =
      Field('dateOfEntryTime', _$dateOfEntryTime, mode: FieldMode.member);

  @override
  final MappableFields<StockSearchModel> fields = const {
    #id: _f$id,
    #tenantId: _f$tenantId,
    #facilityId: _f$facilityId,
    #productVariantId: _f$productVariantId,
    #referenceId: _f$referenceId,
    #referenceIdType: _f$referenceIdType,
    #transactingPartyId: _f$transactingPartyId,
    #transactingPartyType: _f$transactingPartyType,
    #receiverId: _f$receiverId,
    #receiverType: _f$receiverType,
    #senderId: _f$senderId,
    #senderType: _f$senderType,
    #clientReferenceId: _f$clientReferenceId,
    #transactionType: _f$transactionType,
    #transactionReason: _f$transactionReason,
    #dateOfEntry: _f$dateOfEntry,
    #dateOfEntryTime: _f$dateOfEntryTime,
  };
  @override
  final bool ignoreNull = true;

  static StockSearchModel _instantiate(DecodingData data) {
    return StockSearchModel.ignoreDeleted(
        id: data.dec(_f$id),
        tenantId: data.dec(_f$tenantId),
        facilityId: data.dec(_f$facilityId),
        productVariantId: data.dec(_f$productVariantId),
        referenceId: data.dec(_f$referenceId),
        referenceIdType: data.dec(_f$referenceIdType),
        transactingPartyId: data.dec(_f$transactingPartyId),
        transactingPartyType: data.dec(_f$transactingPartyType),
        receiverId: data.dec(_f$receiverId),
        receiverType: data.dec(_f$receiverType),
        senderId: data.dec(_f$senderId),
        senderType: data.dec(_f$senderType),
        clientReferenceId: data.dec(_f$clientReferenceId),
        transactionType: data.dec(_f$transactionType),
        transactionReason: data.dec(_f$transactionReason),
        dateOfEntry: data.dec(_f$dateOfEntry));
  }

  @override
  final Function instantiate = _instantiate;

  static StockSearchModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StockSearchModel>(map);
  }

  static StockSearchModel fromJson(String json) {
    return ensureInitialized().decodeJson<StockSearchModel>(json);
  }
}

mixin StockSearchModelMappable {
  String toJson() {
    return StockSearchModelMapper.ensureInitialized()
        .encodeJson<StockSearchModel>(this as StockSearchModel);
  }

  Map<String, dynamic> toMap() {
    return StockSearchModelMapper.ensureInitialized()
        .encodeMap<StockSearchModel>(this as StockSearchModel);
  }

  StockSearchModelCopyWith<StockSearchModel, StockSearchModel, StockSearchModel>
      get copyWith => _StockSearchModelCopyWithImpl(
          this as StockSearchModel, $identity, $identity);
  @override
  String toString() {
    return StockSearchModelMapper.ensureInitialized()
        .stringifyValue(this as StockSearchModel);
  }

  @override
  bool operator ==(Object other) {
    return StockSearchModelMapper.ensureInitialized()
        .equalsValue(this as StockSearchModel, other);
  }

  @override
  int get hashCode {
    return StockSearchModelMapper.ensureInitialized()
        .hashValue(this as StockSearchModel);
  }
}

extension StockSearchModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StockSearchModel, $Out> {
  StockSearchModelCopyWith<$R, StockSearchModel, $Out>
      get $asStockSearchModel =>
          $base.as((v, t, t2) => _StockSearchModelCopyWithImpl(v, t, t2));
}

abstract class StockSearchModelCopyWith<$R, $In extends StockSearchModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get clientReferenceId;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get transactionType;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get transactionReason;
  $R call(
      {String? id,
      String? tenantId,
      String? facilityId,
      String? productVariantId,
      String? referenceId,
      String? referenceIdType,
      String? transactingPartyId,
      String? transactingPartyType,
      String? receiverId,
      String? receiverType,
      String? senderId,
      String? senderType,
      List<String>? clientReferenceId,
      List<String>? transactionType,
      List<String>? transactionReason,
      int? dateOfEntry});
  StockSearchModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StockSearchModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StockSearchModel, $Out>
    implements StockSearchModelCopyWith<$R, StockSearchModel, $Out> {
  _StockSearchModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StockSearchModel> $mapper =
      StockSearchModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get clientReferenceId => $value.clientReferenceId != null
          ? ListCopyWith(
              $value.clientReferenceId!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(clientReferenceId: v))
          : null;
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get transactionType => $value.transactionType != null
          ? ListCopyWith(
              $value.transactionType!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(transactionType: v))
          : null;
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get transactionReason => $value.transactionReason != null
          ? ListCopyWith(
              $value.transactionReason!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(transactionReason: v))
          : null;
  @override
  $R call(
          {Object? id = $none,
          Object? tenantId = $none,
          Object? facilityId = $none,
          Object? productVariantId = $none,
          Object? referenceId = $none,
          Object? referenceIdType = $none,
          Object? transactingPartyId = $none,
          Object? transactingPartyType = $none,
          Object? receiverId = $none,
          Object? receiverType = $none,
          Object? senderId = $none,
          Object? senderType = $none,
          Object? clientReferenceId = $none,
          Object? transactionType = $none,
          Object? transactionReason = $none,
          Object? dateOfEntry = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (tenantId != $none) #tenantId: tenantId,
        if (facilityId != $none) #facilityId: facilityId,
        if (productVariantId != $none) #productVariantId: productVariantId,
        if (referenceId != $none) #referenceId: referenceId,
        if (referenceIdType != $none) #referenceIdType: referenceIdType,
        if (transactingPartyId != $none)
          #transactingPartyId: transactingPartyId,
        if (transactingPartyType != $none)
          #transactingPartyType: transactingPartyType,
        if (receiverId != $none) #receiverId: receiverId,
        if (receiverType != $none) #receiverType: receiverType,
        if (senderId != $none) #senderId: senderId,
        if (senderType != $none) #senderType: senderType,
        if (clientReferenceId != $none) #clientReferenceId: clientReferenceId,
        if (transactionType != $none) #transactionType: transactionType,
        if (transactionReason != $none) #transactionReason: transactionReason,
        if (dateOfEntry != $none) #dateOfEntry: dateOfEntry
      }));
  @override
  StockSearchModel $make(CopyWithData data) => StockSearchModel.ignoreDeleted(
      id: data.get(#id, or: $value.id),
      tenantId: data.get(#tenantId, or: $value.tenantId),
      facilityId: data.get(#facilityId, or: $value.facilityId),
      productVariantId:
          data.get(#productVariantId, or: $value.productVariantId),
      referenceId: data.get(#referenceId, or: $value.referenceId),
      referenceIdType: data.get(#referenceIdType, or: $value.referenceIdType),
      transactingPartyId:
          data.get(#transactingPartyId, or: $value.transactingPartyId),
      transactingPartyType:
          data.get(#transactingPartyType, or: $value.transactingPartyType),
      receiverId: data.get(#receiverId, or: $value.receiverId),
      receiverType: data.get(#receiverType, or: $value.receiverType),
      senderId: data.get(#senderId, or: $value.senderId),
      senderType: data.get(#senderType, or: $value.senderType),
      clientReferenceId:
          data.get(#clientReferenceId, or: $value.clientReferenceId),
      transactionType: data.get(#transactionType, or: $value.transactionType),
      transactionReason:
          data.get(#transactionReason, or: $value.transactionReason),
      dateOfEntry: data.get(#dateOfEntry, or: $value.dateOfEntry));

  @override
  StockSearchModelCopyWith<$R2, StockSearchModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StockSearchModelCopyWithImpl($value, $cast, t);
}

class StockModelMapper extends ClassMapperBase<StockModel> {
  StockModelMapper._();

  static StockModelMapper? _instance;
  static StockModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StockModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'StockModel';

  static int? _$dateOfEntry(StockModel v) => v.dateOfEntry;
  static const Field<StockModel, int> _f$dateOfEntry =
      Field('dateOfEntry', _$dateOfEntry, opt: true);
  static StockAdditionalDetails? _$additionalFields(StockModel v) =>
      v.additionalFields;
  static const Field<StockModel, StockAdditionalDetails> _f$additionalFields =
      Field('additionalFields', _$additionalFields, opt: true);
  static String? _$id(StockModel v) => v.id;
  static const Field<StockModel, String> _f$id = Field('id', _$id, opt: true);
  static String? _$tenantId(StockModel v) => v.tenantId;
  static const Field<StockModel, String> _f$tenantId =
      Field('tenantId', _$tenantId, opt: true);
  static String? _$facilityId(StockModel v) => v.facilityId;
  static const Field<StockModel, String> _f$facilityId =
      Field('facilityId', _$facilityId, opt: true);
  static String? _$productVariantId(StockModel v) => v.productVariantId;
  static const Field<StockModel, String> _f$productVariantId =
      Field('productVariantId', _$productVariantId, opt: true);
  static String? _$referenceId(StockModel v) => v.referenceId;
  static const Field<StockModel, String> _f$referenceId =
      Field('referenceId', _$referenceId, opt: true);
  static String? _$referenceIdType(StockModel v) => v.referenceIdType;
  static const Field<StockModel, String> _f$referenceIdType =
      Field('referenceIdType', _$referenceIdType, opt: true);
  static String? _$transactingPartyId(StockModel v) => v.transactingPartyId;
  static const Field<StockModel, String> _f$transactingPartyId =
      Field('transactingPartyId', _$transactingPartyId, opt: true);
  static String? _$transactingPartyType(StockModel v) => v.transactingPartyType;
  static const Field<StockModel, String> _f$transactingPartyType =
      Field('transactingPartyType', _$transactingPartyType, opt: true);
  static String? _$quantity(StockModel v) => v.quantity;
  static const Field<StockModel, String> _f$quantity =
      Field('quantity', _$quantity, opt: true);
  static String? _$wayBillNumber(StockModel v) => v.wayBillNumber;
  static const Field<StockModel, String> _f$wayBillNumber =
      Field('wayBillNumber', _$wayBillNumber, opt: true);
  static String? _$clientReferenceId(StockModel v) => v.clientReferenceId;
  static const Field<StockModel, String> _f$clientReferenceId =
      Field('clientReferenceId', _$clientReferenceId, opt: true);
  static String? _$receiverId(StockModel v) => v.receiverId;
  static const Field<StockModel, String> _f$receiverId =
      Field('receiverId', _$receiverId, opt: true);
  static String? _$receiverType(StockModel v) => v.receiverType;
  static const Field<StockModel, String> _f$receiverType =
      Field('receiverType', _$receiverType, opt: true);
  static String? _$senderId(StockModel v) => v.senderId;
  static const Field<StockModel, String> _f$senderId =
      Field('senderId', _$senderId, opt: true);
  static String? _$senderType(StockModel v) => v.senderType;
  static const Field<StockModel, String> _f$senderType =
      Field('senderType', _$senderType, opt: true);
  static bool? _$nonRecoverableError(StockModel v) => v.nonRecoverableError;
  static const Field<StockModel, bool> _f$nonRecoverableError = Field(
      'nonRecoverableError', _$nonRecoverableError,
      opt: true, def: false);
  static int? _$rowVersion(StockModel v) => v.rowVersion;
  static const Field<StockModel, int> _f$rowVersion =
      Field('rowVersion', _$rowVersion, opt: true);
  static String? _$transactionType(StockModel v) => v.transactionType;
  static const Field<StockModel, String> _f$transactionType =
      Field('transactionType', _$transactionType, opt: true);
  static String? _$transactionReason(StockModel v) => v.transactionReason;
  static const Field<StockModel, String> _f$transactionReason =
      Field('transactionReason', _$transactionReason, opt: true);
  static DateTime? _$dateOfEntryTime(StockModel v) => v.dateOfEntryTime;
  static const Field<StockModel, DateTime> _f$dateOfEntryTime =
      Field('dateOfEntryTime', _$dateOfEntryTime, mode: FieldMode.member);

  @override
  final MappableFields<StockModel> fields = const {
    #dateOfEntry: _f$dateOfEntry,
    #additionalFields: _f$additionalFields,
    #id: _f$id,
    #tenantId: _f$tenantId,
    #facilityId: _f$facilityId,
    #productVariantId: _f$productVariantId,
    #referenceId: _f$referenceId,
    #referenceIdType: _f$referenceIdType,
    #transactingPartyId: _f$transactingPartyId,
    #transactingPartyType: _f$transactingPartyType,
    #quantity: _f$quantity,
    #wayBillNumber: _f$wayBillNumber,
    #clientReferenceId: _f$clientReferenceId,
    #receiverId: _f$receiverId,
    #receiverType: _f$receiverType,
    #senderId: _f$senderId,
    #senderType: _f$senderType,
    #nonRecoverableError: _f$nonRecoverableError,
    #rowVersion: _f$rowVersion,
    #transactionType: _f$transactionType,
    #transactionReason: _f$transactionReason,
    #dateOfEntryTime: _f$dateOfEntryTime,
  };
  @override
  final bool ignoreNull = true;

  static StockModel _instantiate(DecodingData data) {
    return StockModel(
        dateOfEntry: data.dec(_f$dateOfEntry),
        additionalFields: data.dec(_f$additionalFields),
        id: data.dec(_f$id),
        tenantId: data.dec(_f$tenantId),
        facilityId: data.dec(_f$facilityId),
        productVariantId: data.dec(_f$productVariantId),
        referenceId: data.dec(_f$referenceId),
        referenceIdType: data.dec(_f$referenceIdType),
        transactingPartyId: data.dec(_f$transactingPartyId),
        transactingPartyType: data.dec(_f$transactingPartyType),
        quantity: data.dec(_f$quantity),
        wayBillNumber: data.dec(_f$wayBillNumber),
        clientReferenceId: data.dec(_f$clientReferenceId),
        receiverId: data.dec(_f$receiverId),
        receiverType: data.dec(_f$receiverType),
        senderId: data.dec(_f$senderId),
        senderType: data.dec(_f$senderType),
        nonRecoverableError: data.dec(_f$nonRecoverableError),
        rowVersion: data.dec(_f$rowVersion),
        transactionType: data.dec(_f$transactionType),
        transactionReason: data.dec(_f$transactionReason));
  }

  @override
  final Function instantiate = _instantiate;

  static StockModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StockModel>(map);
  }

  static StockModel fromJson(String json) {
    return ensureInitialized().decodeJson<StockModel>(json);
  }
}

mixin StockModelMappable {
  String toJson() {
    return StockModelMapper.ensureInitialized()
        .encodeJson<StockModel>(this as StockModel);
  }

  Map<String, dynamic> toMap() {
    return StockModelMapper.ensureInitialized()
        .encodeMap<StockModel>(this as StockModel);
  }

  StockModelCopyWith<StockModel, StockModel, StockModel> get copyWith =>
      _StockModelCopyWithImpl(this as StockModel, $identity, $identity);
  @override
  String toString() {
    return StockModelMapper.ensureInitialized()
        .stringifyValue(this as StockModel);
  }

  @override
  bool operator ==(Object other) {
    return StockModelMapper.ensureInitialized()
        .equalsValue(this as StockModel, other);
  }

  @override
  int get hashCode {
    return StockModelMapper.ensureInitialized().hashValue(this as StockModel);
  }
}

extension StockModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StockModel, $Out> {
  StockModelCopyWith<$R, StockModel, $Out> get $asStockModel =>
      $base.as((v, t, t2) => _StockModelCopyWithImpl(v, t, t2));
}

abstract class StockModelCopyWith<$R, $In extends StockModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  StockAdditionalDetailsCopyWith<$R, StockAdditionalDetails,
      StockAdditionalDetails>? get additionalFields;
  $R call(
      {int? dateOfEntry,
      StockAdditionalDetails? additionalFields,
      String? id,
      String? tenantId,
      String? facilityId,
      String? productVariantId,
      String? referenceId,
      String? referenceIdType,
      String? transactingPartyId,
      String? transactingPartyType,
      String? quantity,
      String? wayBillNumber,
      String? clientReferenceId,
      String? receiverId,
      String? receiverType,
      String? senderId,
      String? senderType,
      bool? nonRecoverableError,
      int? rowVersion,
      String? transactionType,
      String? transactionReason});
  StockModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StockModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StockModel, $Out>
    implements StockModelCopyWith<$R, StockModel, $Out> {
  _StockModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StockModel> $mapper =
      StockModelMapper.ensureInitialized();
  @override
  StockAdditionalDetailsCopyWith<$R, StockAdditionalDetails,
          StockAdditionalDetails>?
      get additionalFields => $value.additionalFields?.copyWith
          .$chain((v) => call(additionalFields: v));
  @override
  $R call(
          {Object? dateOfEntry = $none,
          Object? additionalFields = $none,
          Object? id = $none,
          Object? tenantId = $none,
          Object? facilityId = $none,
          Object? productVariantId = $none,
          Object? referenceId = $none,
          Object? referenceIdType = $none,
          Object? transactingPartyId = $none,
          Object? transactingPartyType = $none,
          Object? quantity = $none,
          Object? wayBillNumber = $none,
          Object? clientReferenceId = $none,
          Object? receiverId = $none,
          Object? receiverType = $none,
          Object? senderId = $none,
          Object? senderType = $none,
          Object? nonRecoverableError = $none,
          Object? rowVersion = $none,
          Object? transactionType = $none,
          Object? transactionReason = $none}) =>
      $apply(FieldCopyWithData({
        if (dateOfEntry != $none) #dateOfEntry: dateOfEntry,
        if (additionalFields != $none) #additionalFields: additionalFields,
        if (id != $none) #id: id,
        if (tenantId != $none) #tenantId: tenantId,
        if (facilityId != $none) #facilityId: facilityId,
        if (productVariantId != $none) #productVariantId: productVariantId,
        if (referenceId != $none) #referenceId: referenceId,
        if (referenceIdType != $none) #referenceIdType: referenceIdType,
        if (transactingPartyId != $none)
          #transactingPartyId: transactingPartyId,
        if (transactingPartyType != $none)
          #transactingPartyType: transactingPartyType,
        if (quantity != $none) #quantity: quantity,
        if (wayBillNumber != $none) #wayBillNumber: wayBillNumber,
        if (clientReferenceId != $none) #clientReferenceId: clientReferenceId,
        if (receiverId != $none) #receiverId: receiverId,
        if (receiverType != $none) #receiverType: receiverType,
        if (senderId != $none) #senderId: senderId,
        if (senderType != $none) #senderType: senderType,
        if (nonRecoverableError != $none)
          #nonRecoverableError: nonRecoverableError,
        if (rowVersion != $none) #rowVersion: rowVersion,
        if (transactionType != $none) #transactionType: transactionType,
        if (transactionReason != $none) #transactionReason: transactionReason
      }));
  @override
  StockModel $make(CopyWithData data) => StockModel(
      dateOfEntry: data.get(#dateOfEntry, or: $value.dateOfEntry),
      additionalFields:
          data.get(#additionalFields, or: $value.additionalFields),
      id: data.get(#id, or: $value.id),
      tenantId: data.get(#tenantId, or: $value.tenantId),
      facilityId: data.get(#facilityId, or: $value.facilityId),
      productVariantId:
          data.get(#productVariantId, or: $value.productVariantId),
      referenceId: data.get(#referenceId, or: $value.referenceId),
      referenceIdType: data.get(#referenceIdType, or: $value.referenceIdType),
      transactingPartyId:
          data.get(#transactingPartyId, or: $value.transactingPartyId),
      transactingPartyType:
          data.get(#transactingPartyType, or: $value.transactingPartyType),
      quantity: data.get(#quantity, or: $value.quantity),
      wayBillNumber: data.get(#wayBillNumber, or: $value.wayBillNumber),
      clientReferenceId:
          data.get(#clientReferenceId, or: $value.clientReferenceId),
      receiverId: data.get(#receiverId, or: $value.receiverId),
      receiverType: data.get(#receiverType, or: $value.receiverType),
      senderId: data.get(#senderId, or: $value.senderId),
      senderType: data.get(#senderType, or: $value.senderType),
      nonRecoverableError:
          data.get(#nonRecoverableError, or: $value.nonRecoverableError),
      rowVersion: data.get(#rowVersion, or: $value.rowVersion),
      transactionType: data.get(#transactionType, or: $value.transactionType),
      transactionReason:
          data.get(#transactionReason, or: $value.transactionReason));

  @override
  StockModelCopyWith<$R2, StockModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StockModelCopyWithImpl($value, $cast, t);
}

class StockAdditionalDetailsMapper
    extends ClassMapperBase<StockAdditionalDetails> {
  StockAdditionalDetailsMapper._();

  static StockAdditionalDetailsMapper? _instance;
  static StockAdditionalDetailsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StockAdditionalDetailsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'StockAdditionalDetails';

  static String? _$version(StockAdditionalDetails v) => v.version;
  static const Field<StockAdditionalDetails, String> _f$version =
      Field('version', _$version);
  static String? _$schema(StockAdditionalDetails v) => v.schema;
  static const Field<StockAdditionalDetails, String> _f$schema =
      Field('schema', _$schema, opt: true, def: 'Stock');
  static List<StockAdditinalField>? _$fields(StockAdditionalDetails v) =>
      v.fields;
  static const Field<StockAdditionalDetails, List<StockAdditinalField>>
      _f$fields = Field('fields', _$fields, opt: true);

  @override
  final MappableFields<StockAdditionalDetails> fields = const {
    #version: _f$version,
    #schema: _f$schema,
    #fields: _f$fields,
  };
  @override
  final bool ignoreNull = true;

  static StockAdditionalDetails _instantiate(DecodingData data) {
    return StockAdditionalDetails(
        version: data.dec(_f$version),
        schema: data.dec(_f$schema),
        fields: data.dec(_f$fields));
  }

  @override
  final Function instantiate = _instantiate;

  static StockAdditionalDetails fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StockAdditionalDetails>(map);
  }

  static StockAdditionalDetails fromJson(String json) {
    return ensureInitialized().decodeJson<StockAdditionalDetails>(json);
  }
}

mixin StockAdditionalDetailsMappable {
  String toJson() {
    return StockAdditionalDetailsMapper.ensureInitialized()
        .encodeJson<StockAdditionalDetails>(this as StockAdditionalDetails);
  }

  Map<String, dynamic> toMap() {
    return StockAdditionalDetailsMapper.ensureInitialized()
        .encodeMap<StockAdditionalDetails>(this as StockAdditionalDetails);
  }

  StockAdditionalDetailsCopyWith<StockAdditionalDetails, StockAdditionalDetails,
          StockAdditionalDetails>
      get copyWith => _StockAdditionalDetailsCopyWithImpl(
          this as StockAdditionalDetails, $identity, $identity);
  @override
  String toString() {
    return StockAdditionalDetailsMapper.ensureInitialized()
        .stringifyValue(this as StockAdditionalDetails);
  }

  @override
  bool operator ==(Object other) {
    return StockAdditionalDetailsMapper.ensureInitialized()
        .equalsValue(this as StockAdditionalDetails, other);
  }

  @override
  int get hashCode {
    return StockAdditionalDetailsMapper.ensureInitialized()
        .hashValue(this as StockAdditionalDetails);
  }
}

extension StockAdditionalDetailsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StockAdditionalDetails, $Out> {
  StockAdditionalDetailsCopyWith<$R, StockAdditionalDetails, $Out>
      get $asStockAdditionalDetails =>
          $base.as((v, t, t2) => _StockAdditionalDetailsCopyWithImpl(v, t, t2));
}

abstract class StockAdditionalDetailsCopyWith<
    $R,
    $In extends StockAdditionalDetails,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
      $R,
      StockAdditinalField,
      StockAdditinalFieldCopyWith<$R, StockAdditinalField,
          StockAdditinalField>>? get fields;
  $R call({String? version, String? schema, List<StockAdditinalField>? fields});
  StockAdditionalDetailsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StockAdditionalDetailsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StockAdditionalDetails, $Out>
    implements
        StockAdditionalDetailsCopyWith<$R, StockAdditionalDetails, $Out> {
  _StockAdditionalDetailsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StockAdditionalDetails> $mapper =
      StockAdditionalDetailsMapper.ensureInitialized();
  @override
  ListCopyWith<
      $R,
      StockAdditinalField,
      StockAdditinalFieldCopyWith<$R, StockAdditinalField,
          StockAdditinalField>>? get fields => $value.fields != null
      ? ListCopyWith($value.fields!, (v, t) => v.copyWith.$chain(t),
          (v) => call(fields: v))
      : null;
  @override
  $R call(
          {Object? version = $none,
          Object? schema = $none,
          Object? fields = $none}) =>
      $apply(FieldCopyWithData({
        if (version != $none) #version: version,
        if (schema != $none) #schema: schema,
        if (fields != $none) #fields: fields
      }));
  @override
  StockAdditionalDetails $make(CopyWithData data) => StockAdditionalDetails(
      version: data.get(#version, or: $value.version),
      schema: data.get(#schema, or: $value.schema),
      fields: data.get(#fields, or: $value.fields));

  @override
  StockAdditionalDetailsCopyWith<$R2, StockAdditionalDetails, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _StockAdditionalDetailsCopyWithImpl($value, $cast, t);
}

class StockAdditinalFieldMapper extends ClassMapperBase<StockAdditinalField> {
  StockAdditinalFieldMapper._();

  static StockAdditinalFieldMapper? _instance;
  static StockAdditinalFieldMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StockAdditinalFieldMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'StockAdditinalField';

  static String? _$key(StockAdditinalField v) => v.key;
  static const Field<StockAdditinalField, String> _f$key =
      Field('key', _$key, opt: true);
  static dynamic _$value(StockAdditinalField v) => v.value;
  static const Field<StockAdditinalField, dynamic> _f$value =
      Field('value', _$value, opt: true);

  @override
  final MappableFields<StockAdditinalField> fields = const {
    #key: _f$key,
    #value: _f$value,
  };
  @override
  final bool ignoreNull = true;

  static StockAdditinalField _instantiate(DecodingData data) {
    return StockAdditinalField(
        key: data.dec(_f$key), value: data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static StockAdditinalField fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StockAdditinalField>(map);
  }

  static StockAdditinalField fromJson(String json) {
    return ensureInitialized().decodeJson<StockAdditinalField>(json);
  }
}

mixin StockAdditinalFieldMappable {
  String toJson() {
    return StockAdditinalFieldMapper.ensureInitialized()
        .encodeJson<StockAdditinalField>(this as StockAdditinalField);
  }

  Map<String, dynamic> toMap() {
    return StockAdditinalFieldMapper.ensureInitialized()
        .encodeMap<StockAdditinalField>(this as StockAdditinalField);
  }

  StockAdditinalFieldCopyWith<StockAdditinalField, StockAdditinalField,
          StockAdditinalField>
      get copyWith => _StockAdditinalFieldCopyWithImpl(
          this as StockAdditinalField, $identity, $identity);
  @override
  String toString() {
    return StockAdditinalFieldMapper.ensureInitialized()
        .stringifyValue(this as StockAdditinalField);
  }

  @override
  bool operator ==(Object other) {
    return StockAdditinalFieldMapper.ensureInitialized()
        .equalsValue(this as StockAdditinalField, other);
  }

  @override
  int get hashCode {
    return StockAdditinalFieldMapper.ensureInitialized()
        .hashValue(this as StockAdditinalField);
  }
}

extension StockAdditinalFieldValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StockAdditinalField, $Out> {
  StockAdditinalFieldCopyWith<$R, StockAdditinalField, $Out>
      get $asStockAdditinalField =>
          $base.as((v, t, t2) => _StockAdditinalFieldCopyWithImpl(v, t, t2));
}

abstract class StockAdditinalFieldCopyWith<$R, $In extends StockAdditinalField,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? key, dynamic value});
  StockAdditinalFieldCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StockAdditinalFieldCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StockAdditinalField, $Out>
    implements StockAdditinalFieldCopyWith<$R, StockAdditinalField, $Out> {
  _StockAdditinalFieldCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StockAdditinalField> $mapper =
      StockAdditinalFieldMapper.ensureInitialized();
  @override
  $R call({Object? key = $none, Object? value = $none}) =>
      $apply(FieldCopyWithData(
          {if (key != $none) #key: key, if (value != $none) #value: value}));
  @override
  StockAdditinalField $make(CopyWithData data) => StockAdditinalField(
      key: data.get(#key, or: $value.key),
      value: data.get(#value, or: $value.value));

  @override
  StockAdditinalFieldCopyWith<$R2, StockAdditinalField, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _StockAdditinalFieldCopyWithImpl($value, $cast, t);
}
