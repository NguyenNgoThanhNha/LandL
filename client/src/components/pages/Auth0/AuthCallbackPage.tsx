import Loading from "@/components/templates/Loading";
import { useAuth0 } from "@auth0/auth0-react"
import { useEffect, useRef } from "react";
import { useNavigate } from "react-router-dom";

const AuthCallbackPage = () => {
    const navigate = useNavigate();
    const { user } = useAuth0();
    // const { createUser } = useCreateMyUser();
    console.log(user)
    const hasCreatedUser = useRef(false);

    useEffect(() => {
        if (user?.sub && user?.email && !hasCreatedUser.current) {
            // createUser({ auth0Id: user.sub, email: user.email }); login with google api
            hasCreatedUser.current = true;
            console.log(11111111111111111111111)
        }
        // navigate("/");
    }, [user, navigate])
    return (
        <Loading />
    )
}

export default AuthCallbackPage