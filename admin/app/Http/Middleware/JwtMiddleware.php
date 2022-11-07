<?php

namespace App\Http\Middleware;

use Config;
use Closure;

use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Tymon\JWTAuth\Exceptions\TokenInvalidException;
use Tymon\JWTAuth\Exceptions\TokenExpiredException;

class JwtMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        try {
            if (! $user = JWTAuth::parseToken()->authenticate()) {

                return response()->json([
                    'message' => 'user not found',
                    'status'=>false,
                    'status_code' => false
                ]);
            } else {
                \Auth::loginUsingId($user->id);
            }

        } catch (TokenExpiredException $e) {
            // $e->getStatusCode()
            return response()->json([
                'message' => $e->getMessage(),
                'status'=>false,
                'status_code' => false
            ]);

        } catch (TokenInvalidException $e) {

            return response()->json([
                'message' => 'token_invalid',
                'status'=>false,
                'status_code' => false
            ]);

        } catch (JWTException $e) {
            return response()->json([
                'message' => 'token_expired',
                'status'=>false,
                'status_code' => false
            ]);

        }

        return $next($request);
    }
}
