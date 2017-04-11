namespace FifaPSLTournaments.Helper
{
    public static class Helper
    {
        public static string Truncate(string text, int length)
        {
            if (text.Length > length && length > 4)
            {
                return text.Substring(0, length - 2) + "...";
            }

            return text;
        }
    }
}
