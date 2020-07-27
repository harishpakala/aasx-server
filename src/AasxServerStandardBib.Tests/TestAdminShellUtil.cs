using NUnit.Framework;

namespace AdminShellNS.Tests
{
    public class TestEvalToNonNullString
    {
        [Test]
        public void NonNull_Gives_Formatted()
        {
            var result = AdminShellUtil.EvalToNonNullString(
                "some message: {0}", 1984, "something else");

            Assert.That(result, Is.EqualTo("some message: 1984"));
        }

        [Test]
        public void Null_Gives_ElseString()
        {
            var result = AdminShellUtil.EvalToNonNullString(
                            "some message: {0}", null, "something else");

            Assert.That(result, Is.EqualTo("something else"));
        }
    }
}
