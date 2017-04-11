namespace FifaPSLTournaments.Model
{
    using System;

    public partial class UserDto
    {        
        public int Id { get; set; }

        public int IdRol { get; set; }

        public string Name { get; set; }

        public string UserName { get; set; }

        public string Password { get; set; }

        public string Email { get; set; }

        public DateTime CreationDate { get; set; }

        public bool Active { get; set; }

        public RoleDto Role { get; set; }
    }
}
