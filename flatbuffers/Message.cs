// <auto-generated>
//  automatically generated by the FlatBuffers compiler, do not modify
// </auto-generated>

namespace spicle
{

using global::System;
using global::System.Collections.Generic;
using global::Google.FlatBuffers;

public struct Message : IFlatbufferObject
{
  private Table __p;
  public ByteBuffer ByteBuffer { get { return __p.bb; } }
  public static void ValidateVersion() { FlatBufferConstants.FLATBUFFERS_24_12_23(); }
  public static Message GetRootAsMessage(ByteBuffer _bb) { return GetRootAsMessage(_bb, new Message()); }
  public static Message GetRootAsMessage(ByteBuffer _bb, Message obj) { return (obj.__assign(_bb.GetInt(_bb.Position) + _bb.Position, _bb)); }
  public static bool VerifyMessage(ByteBuffer _bb) {Google.FlatBuffers.Verifier verifier = new Google.FlatBuffers.Verifier(_bb); return verifier.VerifyBuffer("", false, MessageVerify.Verify); }
  public void __init(int _i, ByteBuffer _bb) { __p = new Table(_i, _bb); }
  public Message __assign(int _i, ByteBuffer _bb) { __init(_i, _bb); return this; }

  public long Timestamp { get { int o = __p.__offset(4); return o != 0 ? __p.bb.GetLong(o + __p.bb_pos) : (long)0; } }
  public string Data { get { int o = __p.__offset(6); return o != 0 ? __p.__string(o + __p.bb_pos) : null; } }
#if ENABLE_SPAN_T
  public Span<byte> GetDataBytes() { return __p.__vector_as_span<byte>(6, 1); }
#else
  public ArraySegment<byte>? GetDataBytes() { return __p.__vector_as_arraysegment(6); }
#endif
  public byte[] GetDataArray() { return __p.__vector_as_array<byte>(6); }

  public static Offset<spicle.Message> CreateMessage(FlatBufferBuilder builder,
      long timestamp = 0,
      StringOffset dataOffset = default(StringOffset)) {
    builder.StartTable(2);
    Message.AddTimestamp(builder, timestamp);
    Message.AddData(builder, dataOffset);
    return Message.EndMessage(builder);
  }

  public static void StartMessage(FlatBufferBuilder builder) { builder.StartTable(2); }
  public static void AddTimestamp(FlatBufferBuilder builder, long timestamp) { builder.AddLong(0, timestamp, 0); }
  public static void AddData(FlatBufferBuilder builder, StringOffset dataOffset) { builder.AddOffset(1, dataOffset.Value, 0); }
  public static Offset<spicle.Message> EndMessage(FlatBufferBuilder builder) {
    int o = builder.EndTable();
    return new Offset<spicle.Message>(o);
  }
  public static void FinishMessageBuffer(FlatBufferBuilder builder, Offset<spicle.Message> offset) { builder.Finish(offset.Value); }
  public static void FinishSizePrefixedMessageBuffer(FlatBufferBuilder builder, Offset<spicle.Message> offset) { builder.FinishSizePrefixed(offset.Value); }
}


static public class MessageVerify
{
  static public bool Verify(Google.FlatBuffers.Verifier verifier, uint tablePos)
  {
    return verifier.VerifyTableStart(tablePos)
      && verifier.VerifyField(tablePos, 4 /*Timestamp*/, 8 /*long*/, 8, false)
      && verifier.VerifyString(tablePos, 6 /*Data*/, false)
      && verifier.VerifyTableEnd(tablePos);
  }
}

}
